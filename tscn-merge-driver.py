import sys

our_path = sys.argv[1] # our version of the file
base_path = sys.argv[2] # base version of the file
their_path = sys.argv[3] # their version of the file
filename = sys.argv[4] # real file name

with open(our_path) as f_our, open(base_path) as f_base, open(their_path) as f_their:
    content_our = f_our.readlines() # Lines of our version
    content_base = f_base.readlines() # Lines of base version
    content_their = f_their.readlines() # Lines of their version
