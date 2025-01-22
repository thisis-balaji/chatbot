from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
import db
import generic

app = FastAPI()
import uvicorn

# uvicorn.run(app, host="127.0.0.1", port=8000, timeout_keep_alive=600)
progress_order = {}


@app.post("/")
async def handle_request(request: Request):
    # Retrieve the JSON data from the request
    payload = await request.json()

    # Extract the necessary information from the payload
    # based on the structure of the WebhookRequest from Dialogflow
    intent = payload['queryResult']['intent']['displayName']
    parameters = payload['queryResult']['parameters']
    output_contexts = payload['queryResult']['outputContexts']

    session_id = generic.extract_session_id(output_contexts[0]["name"])

    intent_handler_dict = {
        'track.order - context: ongoing-tracking': track_order,
        'order.add - context: ongoing-order': add_order,
        'order.complete - context : ongoing-order': complete_order,
        'order.remove - context: ongoing-order': remove_from_order
    }

    return intent_handler_dict[intent](parameters, session_id)


def remove_from_order(parameters: dict, session_id: str):
    global fulfillment_text
    try:
        if session_id not in progress_order:
            return JSONResponse(content={
                "fulfillmentText": "I'm having trouble finding your order. Sorry! Can you place a new order?"
            })

        current_order = progress_order[session_id]
        products = parameters.get("product_name", [])

        removed_items = []
        no_such_items = []
        for item in products:
            if item not in current_order:
                no_such_items.append(item)
            else:
                removed_items.append(item)
                del current_order[item]

        if len(removed_items) > 0:
            fulfillment_text = f"Removed {','.join(removed_items)} from your order."

        if len(no_such_items) > 0:
            fulfillment_text = f"Your current order does not have {','.join(no_such_items)}."

        if len(current_order.keys()) == 0:
            fulfillment_text += " Your order is empty!"
        else:
            order_str = generic.get_str_from_product_dict(current_order)
            fulfillment_text += f" Here is what's left in your order: {order_str}"

        return JSONResponse(content={
            "fulfillmentText": fulfillment_text
        })

    except Exception as e:
        # Log error for debugging
        print(f"Error in remove_from_order: {e}")
        return JSONResponse(content={
            "fulfillmentText": "An error occurred while processing your request. Please try again."
        })


def track_order(parameters: dict, session_id: str):
    order_id = int(parameters['order_id'])
    order_status = db.get_order_status(order_id)

    if order_status:
        fulfillment_text = f"The order status for order id {order_id} is: {order_status}"
    else:
        fulfillment_text = f"There is no order with order id : {order_id}"

    return JSONResponse(content={
        "fulfillmentText": fulfillment_text
    })


def complete_order(parameters: dict, session_id: str):
    if session_id not in progress_order:
        fulfillment_text = "I am having a trouble finding your order. Sorry! Can you place a new order"
    else:
        order = progress_order[session_id]
        order_id = save_to_db(order)

        if order_id == -1:
            fulfillment_text = "Sorry I could not process your order due to a Backend error,Please place a new order"
        else:
            order_total = db.get_total_order_price(order_id)
            fulfillment_text = f"Awesome we have placed your order. " \
                               f"Here is your order id #{order_id}." \
                               f"Your order total is {order_total}"

        del progress_order[session_id]

    return JSONResponse(content={
        "fulfillmentText": fulfillment_text
    })


def save_to_db(order: dict):
    next_order_id = db.get_next_order_id()

    for product_name, quantity in order.items():
        rcode = db.insert_order_item(
            product_name,
            quantity,
            next_order_id
        )

        if rcode == -1:
            return -1

    db.insert_order_tracking(next_order_id, "in progress")

    return next_order_id


def add_order(parameters: dict, session_id: str):
    products = parameters["product_name"]
    quantities = parameters["quantity"]

    if len(products) != len(quantities):
        fulfillment_text = "Sorry, I didn't understand. Can you please clearly specify the product name and quantity?"
    else:
        new_product_dict = dict(zip(products, quantities))

        if session_id in progress_order:
            current_product_dict = progress_order[session_id]
            current_product_dict.update(new_product_dict)
            progress_order[session_id] = current_product_dict
        else:
            progress_order[session_id] = new_product_dict

        order_str = generic.get_str_from_product_dict(progress_order[session_id])
        fulfillment_text = f"So far you have: {order_str}. Do you need anything else?"

    return JSONResponse(content={
        "fulfillmentText": fulfillment_text
    })


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
