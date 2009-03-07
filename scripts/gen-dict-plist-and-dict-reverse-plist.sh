#!/bin/sh

./dict-txt-2-dict-plist.py > ../dict.plist
echo "generated dict.plist"
./gen-reverse-dict.py | ./dict-txt-2-dict-plist.py -s > ../dict-reverse.plist
echo "generated dict-reverse.plist"
