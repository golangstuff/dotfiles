#!/usr/bin/env python3
# Bing Wallpapers from cn.bing.com

import os
import urllib.request
import datetime
import shutil

url = "https://cn.bing.com"
dir = "~/usr/wallpapers/"


dir_parent = os.path.expanduser(dir)
dir_cur = dir_parent + 'current/'
dir_his = dir_parent + 'previous/'

flag = 0
r = urllib.request.urlopen(url)
html = r.read().decode(r.headers.get_content_charset())
for x in range(html.find('g_img={'),(html.find('g_img={')+100)):
    if html[x] == "'":
        if flag == 1:
            break
        else:
            flag = 1
            continue
    elif flag == 1:
        url += html[x]

file_name = dir_cur + url.split('/')[-1].split('#')[0].split('?')[0]

if not os.path.exists(file_name):
    if not os.path.exists(dir_his):
        os.makedirs(dir_his)
    if not os.path.exists(dir_cur):
        os.makedirs(dir_cur)
    else:
        dir_newname = dir_parent + datetime.datetime.now().strftime("%Y%m%d")
        os.rename(dir_cur,dir_newname)
        shutil.move(dir_newname, dir_his)
        os.makedirs(dir_cur)
    with urllib.request.urlopen(url) as response, open(file_name, 'wb') as out_file:
        shutil.copyfileobj(response, out_file)
