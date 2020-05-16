#!/usr/bin/env python

import sys, time, random, signal

def delaykey(t, p=15): 
    time.sleep(t + random.random() / p)

signal.signal(signal.SIGINT, lambda x, y: sys.exit(1))

for line in sys.stdin: 
    for char in line: 
        if char == '\n': 
            delaykey(0.17)
        elif char == '\t': 
            delaykey(0.15)
        
        sys.stdout.write(char)
        sys.stdout.flush()
        delaykey(0.04)
delaykey(0.3, 5)
