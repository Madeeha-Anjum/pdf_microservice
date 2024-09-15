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


@app.get("/create-receipt", response_class=FileResponse)
def create_receipt(
    client_first_name: str,
    client_last_name: str,
    client_email: str,
    client_phone: str,
    client_address: str,
    client_city: str,
    client_state: str,
    client_postal: str,
    client_country: str,
    items: list[Item],
) -> FileResponse:
    pdf = HTML(string="<h1>Hello World</h1>").write_pdf("hello-world.pdf")
    bytes = io.BytesIO(pdf)
    bytes.seek(0)
    return FileResponse(
        "hello-world.pdf", media_type="application/pdf", filename="hello-world.pdf"
    )
