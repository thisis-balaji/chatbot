from fastapi import FastAPI
from enum import Enum
app = FastAPI()

class available_cuisines(str, Enum):
    indian = "indian"
    italian = "italian"
    american = "american"

food_items = {
    'indian' : ["Samosa", "Dosa"],
    'italian' : ["Pizza", "Hotdog"],
    'american' : ["Ravioli", "Apple Pie"]
}
@app.get("/getitems/{cuisine}")
async def getitems(cuisine : available_cuisines):
    return food_items.get(cuisine)

coupon_code = {
    1: '10%',
    2: '20%',
    3: '30%'
}

@app.get("/get_coupon_code/{coupon}")
async def get_coupon_code(coupon : int):
    return coupon_code.get(coupon)
