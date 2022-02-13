#!/usr/bin/python
 
import sys
import random
import string
 
# Import the library
import argparse
# Create the parser
parser = argparse.ArgumentParser()
# Add an argument
parser.add_argument('--length', type=int, required=True)
# Parse the argument
args = parser.parse_args()
 
combo = string.ascii_letters + string.digits # + string.punctuation
 
length = args.length
 
password = "".join(random.sample(combo, length))
 
print(password)