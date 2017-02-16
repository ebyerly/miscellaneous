import urllib.request
import urllib.parse
from bs4 import BeautifulSoup
import re
import os
import time

def podcastScrape(destination, source, type = 'mp3', pattern = ''):
    pattern = re.compile(pattern + ".*\." + type + "$")
    try:
        os.mkdir(destination)
    except FileExistsError:
        pass
    response = urllib.request.urlopen(source)
    soup = BeautifulSoup(response)
    links = [link.get('href') for link in soup.find_all('a', href = pattern)]
    for link in set(links):
        nm = os.path.basename(link)
        urllib.request.urlretrieve(link, os.path.join(destination, nm))
        time.sleep(1)
