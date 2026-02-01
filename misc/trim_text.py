#!/usr/bin/python3

import sys
import re

filename = sys.argv[1]

for line in open(filename):
    line = re.sub('\d+\.', ' ', line)
    line = re.sub('[*]', ' ', line)
    line = re.sub('\s{2,}', ' ', line)
    line = line.strip()
    print(line)
