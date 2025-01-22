import re


def extract_session_id(session_str: str):
    match = re.search("\/sessions\/(.*)\/contexts", session_str)
    if match:
        extracted_string = match.group(1)
        return extracted_string

    return


def get_str_from_product_dict(product_dict: dict):
    return ", ".join([f"{int(value)} {key}" for key, value in product_dict.items()])



if __name__ == "__main__":
    print(get_str_from_product_dict({"samose" : 2, "cholle":2}))
        # "projects/c-selectric-qycq/agent/sessions/c5bc4ae8-64af-f7ac-847d-18563123eed1/contexts/ongoingorder"))
