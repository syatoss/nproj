'''sas'''
import os
import sys


dir_path = sys.argv[1]
mod_file_name = sys.argv[2]
proj_name = sys.argv[3]


full_path = os.path.join(dir_path, mod_file_name)


def mod_makefile(path):
    '''asda'''
    lines = []
    with open(path, 'r') as file:
        lines = file.readlines()
    lines[2] = lines[2].replace('main', proj_name)
    with open(path, 'w') as file:
        file.writelines(lines)


def mod_html(path):
    '''sad'''
    lines = []
    with open(path, 'r') as file:
        lines = file.readlines()
    lines[6] = lines[6].replace('index', proj_name)
    lines[7] = lines[7].replace('Document', proj_name)
    lines[15] = lines[15].replace('index', proj_name)
    with open(path, 'w') as file:
        file.writelines(lines)


if 'makefile' in mod_file_name:
    mod_makefile(full_path)
elif 'html' in mod_file_name:
    mod_html(full_path)
