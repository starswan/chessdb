#!/usr/bin/env python3

# for some strange reason, TWIC stopped allowing scraping of the homepage using the python
# libraries, returning a '406' (no version of content found) - no had to change
# algorithm to just guessing when the next TWIC issue is out (starting from the
# last downloaded issue, 1398) - we were using wget to download the archives anyway...
# from bs4 import BeautifulSoup
# import urllib
import os.path
import sys
#
import subprocess
from bs4 import BeautifulSoup

req = subprocess.run(['wget', '-O', '-', 'https://theweekinchess.com/twic'], capture_output=True)
# doc = urllib.request.urlopen('https://www.theweekinchess.com/twic').read()
# headers={
#   'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
#   'Accept-Language': 'en-GB,en;q=0.5'
# }
# req = requests.get('https://www.theweekinchess.com/twic',headers=headers)
# # Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
# print(req.request.headers)
# print(req.text)
page = BeautifulSoup(req.stdout, 'html.parser')
# from datetime import date, timedelta
# twic1398 = date(2021, 8, 23)
# weeks_since_twic1398 = int((date.today() - twic1398).days / 7)
#
basedir = sys.argv[1]
# for offset in range(weeks_since_twic1398):
#     twic = str(1399 + offset)
#     href = "https://theweekinchess.com/zips/twic" + twic + "g.zip"
#     filename = basedir + "/twic" + twic + ".pgn"
#     if not os.path.exists(filename):
#         os.system('wget -q --mirror -nH --cut-dirs=2 ' + href)
#     filename2 = basedir + "/twic" + twic + ".cbv"
#     if not os.path.exists(filename2):
#         href2 = "https://theweekinchess.com/zips/twic" + twic + "c6.zip"
#         print("href", href2, 'filename', filename2)
#         os.system('wget -q --mirror -nH --cut-dirs=2 ' + href2)

for tag in page.findAll('a'):
   href = tag.get('href')
   if ('g.zip' in href):
      filename = basedir + '/' + os.path.basename(href).replace('g.zip', '.pgn')
      if not os.path.exists(filename):
         os.system('wget -q --mirror -nH --cut-dirs=2 ' + href)
         print(filename)
   if ('c6.zip' in href):
      filename = basedir + '/' + os.path.basename(href).replace('c6.zip', '.cbv')
      if not os.path.exists(filename):
         os.system('wget -q --mirror -nH --cut-dirs=2 ' + href)
