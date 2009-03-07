#!/usr/bin/env python
# -*- coding: utf-8 -*-
import re
import locale
locale.setlocale(locale.LC_ALL, 'cs_CZ.ISO8859-2')

DICT_LINE_RE = re.compile(r'''^\s+(.*?)\s*~\s*(.*)\s*$''', re.U)

def encode_for_locale(u):
    return u.encode('ISO8859-2')

def decode_to_utf(s_encoded_for_locale):
    return s_encoded_for_locale.decode('ISO8859-2').encode('utf-8')

def main():
    f = open('../dict.txt')
    dict_per_first_letters = {}
    for line in f:
        line = line.decode('utf-8')
        match = DICT_LINE_RE.match(line)
        if match:
            original, translation = match.groups()
            
            first_letter = None
            if translation.upper().startswith('CH'):
                first_letter = 'CH'
            else:
                first_letter = translation.upper()[0]
                
            dict_per_first_letters.setdefault(encode_for_locale(first_letter), []) \
                .append((encode_for_locale(translation), original))
        # else:
        #     print line.encode('utf-8'),
    
    sorted_first_letters = dict_per_first_letters.keys()
    sorted_first_letters.sort(cmp=locale.strcoll)
    
    for first_letter in sorted_first_letters:
        print decode_to_utf(first_letter)
        dict_per_first_letters[first_letter].sort(cmp=locale.strcoll, key=lambda x: x[0])
        for original, translation in dict_per_first_letters[first_letter]:
            print '    %s ~ %s' % (decode_to_utf(original), translation.encode('utf-8'))
            pass

if __name__ == '__main__':
    main()