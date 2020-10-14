#!/usr/bin/env python3
import requests
from lxml import etree

def getLastRelease(url='https://forums.kleientertainment.com/game-updates/dst/'):
    content=etree.HTML(requests.get(url).text)
    release_list=[int(r.strip()) for r in content.xpath('//*[@data-currentrelease]//h3[@class="ipsType_sectionHead ipsType_break"]/text()') if not r.isspace()]
    res=max(release_list)
    print(res)
    return res

if __name__=='__main__':
    getLastRelease()