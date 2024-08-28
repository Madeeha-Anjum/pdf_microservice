import io
from typing import Union
from fastapi import FastAPI
from fastapi.responses import FileResponse
from pydantic import BaseModel
from weasyprint import HTML

app = FastAPI()


class Item(BaseModel):
    name: str
    price: float
    is_offer: Union[bool, None] = None


@app.get("/", response_class=FileResponse)
def read_root() -> FileResponse:
    pdf = HTML(string="<h1>Hello World</h1>").write_pdf("hello-world.pdf")
    bytes = io.BytesIO(pdf)
    bytes.seek(0)
    return FileResponse("hello-world.pdf", media_type="application/pdf", filename="hello-world.pdf")
    
    
@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}
 

@app.put("/items/{item_id}")
def update_item(item_id: int, item: Item):
    return {"item_name": item.name, "item_id": item_id}