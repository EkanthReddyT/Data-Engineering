import numpy as np
import pandas as pd
import json 

def load_data(path_list):
    base_path = "JSON/"
    dfs = []
    for path in path_list:
        full_path = base_path+path
        with open(full_path, "r",encoding="utf-8") as f:
            data = json.load(f)
        df = pd.json_normalize(data)
        dfs.append(df)
    return pd.concat(dfs, ignore_index=True)

def add_cols(df):
    # per-row string length
    # In case any values are missing (NaN) or non-string types (like numbers), .str.len() would raise an error.
    try:
        df["name_length"] = df["user.name"].str.len()
        df["department_length"] = df["user.department"].str.len()
        df["email_length"] = df["user.email"].str.len()
        return df
    except Exception as e:
        print(f"Error occured: {e}")