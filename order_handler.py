# order_handler.py

def handle_order_add(parameters: dict, session_id: str):
    try:
        item = parameters.get("product_name")[0]
        quantity = parameters.get("number")[0]

        response = {
            "fulfillmentText": f"Added {quantity} of {item} to your order.",
            "source": "webhook"
        }
        return response
    except Exception as e:
        return {
            "fulfillmentText": "Failed to process order add request.",
            "source": "webhook",
            "error": str(e)
        }


def handle_order_remove(parameters: dict, session_id: str):
    try:
        item = parameters.get("product_name")[0]

        response = {
            "fulfillmentText": f"Removed {item} from your order.",
            "source": "webhook"
        }
        return response
    except Exception as e:
        return {
            "fulfillmentText": "Failed to process order remove request.",
            "source": "webhook",
            "error": str(e)
        }
