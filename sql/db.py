#! /usr/bin/python
import sys
import os
import json

SQL_EXT = ".sql"
RUN_FILENAME="run.json"
RESULT_DIR="_out"

COMMAND_PATH=None
COMMAND=None

def run(args):
    global COMMAND_PATH
    global COMMAND
    COMMAND = args[1]
    COMMAND_PATH = os.path.join(os.getcwd(), COMMAND)
    run_path = os.path.join(COMMAND_PATH, RUN_FILENAME)
    with open(run_path) as f:
        data = json.load(f)
    for op in data:
        if op == 'Files':
            files_op(data[op])
    return

def files_op(files):
    global COMMAND_PATH
    global RESULT_DIR
    global COMMAND
    result_dir = os.path.join(os.getcwd(), RESULT_DIR)
    if not (os.path.exists(result_dir)):
            os.makedirs(result_dir)
    result_path = os.path.join(result_dir, COMMAND+'.sql');
    with open(result_path, 'w', encoding="utf-8") as resfile:
        for fitem in files:
            sqlpath = os.path.join(COMMAND_PATH, fitem['Module'], fitem['Table']+'.sql')
            print(' -> ' + fitem['Table'] + '.sql')
            with open(sqlpath, encoding="utf-8") as infile:
                resfile.write(infile.read())
    return

if __name__ == "__main__":
    run(sys.argv)
