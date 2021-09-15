import json
import requests

with open('Accounts.json', encoding="utf-8") as f:
    d = json.load(f)    
url = 'http://localhost:8080/svcm/AclAccounts'
headers = {'content-type':'application/json' }
for elem in d['value']:
    resp = requests.post(url, data=json.dumps(elem), headers=headers, auth=('admin','admin'))
    resp_json = resp.json()
    print(resp_json)

