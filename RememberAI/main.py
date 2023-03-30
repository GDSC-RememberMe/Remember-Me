from fastapi import FastAPI 
from doc_cluster import * 
from pydantic import BaseModel

app = FastAPI()

class InputText(BaseModel):
    contents: str

CAT_LIST = ["결혼", "물놀이", "졸업", "명절", "일상", "요리", "운동", "등산", "생일", "식사"]

@app.post("/keyword/")
async def keywords(text: InputText):
    input_txt = text.dict()
    
    category, keyword = get_cat_key(sentence=input_txt['contents'],
                                    cat_lst=CAT_LIST)

    data = {
        "category" : category,
        "keyword" : keyword
        }
    return data
