#!/usr/bin/env python3
# Bing Wallpapers from cn.bing.com
import urllib.request

url = 'https://cn.bing.com'

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
print(url)
