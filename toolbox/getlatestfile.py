#!/usr/bin/python

import os
import urllib
import subprocess

response = urllib.urlopen('http://www.gnss.it.pt/ub1/')
html = response.readlines()

line=html[-6]

latestfile=line[81:100]
latestfilecheck=open(os.getcwd()+r'/latestfile',"r")
latestavailable=latestfilecheck.read()

if latestavailable == latestfile:
	exit()
else:
	subprocess.call(os.getcwd()+r"/cleanup.sh", shell=True)

fileurl='http://www.gnss.it.pt/ub1/'+latestfile

output=open(os.getcwd()+r'/latestfile',"w+")
output.write(latestfile)

file=urllib.URLopener()
file.retrieve(fileurl,latestfile)
