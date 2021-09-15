#! /usr/bin/python
import sys
import os
import json
import requests

ODATA_BASE = "http://localhost:8080/svcm/"

RUN_FILENAME ="run.json"
RUN_PATH = None

CMD_DIR = None
CMD_ACTION = None
CMD_PATH = None

def run():
    read_args()
    run_path = os.path.join(CMD_PATH, RUN_FILENAME)
    with open(run_path, encoding="utf-8") as f:
        op_list = json.load(f)
    for op in op_list:
        if op == 'Files':
            globals()['act_' + CMD_ACTION](op_list[op])
    return

def act_pop(entity_list):
    for entity in entity_list:
        url = ODATA_BASE + entity['Name']
        respath = os.path.join(CMD_PATH, entity['Module'], entity['Name'] + '.json')
        with open(respath, 'w', encoding='utf-8') as resfile:
            resp = requests.get(url, auth=('admin', 'admin'))
            resp_json = json.loads(resp.text)
            for elem in resp_json['value']:  
                elem.pop('Id', None)
            resfile.write(json.dumps(resp_json, ensure_ascii=False, indent=4))
    return

def act_push(entity_list):
    headers = {'content-type':'application/json' }
    for entity in entity_list:
        file_path = os.path.join(CMD_PATH, entity['Module'], entity['Name'] + '.json')
        # print(file_path)
        url = ODATA_BASE + entity['Name']
        with open(file_path, encoding="utf-8") as f:
            d = json.load(f)
            for elem in d['value']:
                resp = requests.post(url, data=json.dumps(elem), headers=headers, auth=('admin', 'admin'))
                if (resp.status_code != 201):
                    msg = '\n' + resp.url +  ' - response.status_code: ' + str(resp.status_code) + '\n'
                    print(msg)
                    resp.raise_for_status()
                # print(url)
                # resp_json = resp.json()
                # print(json.dumps(resp.text, ensure_ascii=False, indent=4))
    return

def read_args():
    global CMD_PATH
    global CMD_DIR
    global CMD_ACTION
    global RUN_PATH
    if (len(sys.argv) < 3):
        print('ERROR: Few arguments')
        print_usage()
        exit()
    CMD_DIR = sys.argv[1]
    CMD_PATH = os.path.join(os.getcwd(), CMD_DIR)
    CMD_ACTION = sys.argv[2]
    return

def print_usage():
    print('data.py <FOLDER> <COMMAND>')
    return
    
if __name__ == "__main__":
    run()

