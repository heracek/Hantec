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

def sort_words_and_join_the_same_words_and_move_notes_to_traslations(dict_per_first_letters):
    
    for first_letter in dict_per_first_letters.keys():
        dict_per_first_letters[first_letter].sort(cmp=locale.strcoll, key=lambda x: x[0][0])
        old_translations = dict_per_first_letters[first_letter]
                
        joined_translations = []
        first_found_original = None
        the_same_originals_translations = None
        notes = []
        
        for (original, note), translation in old_translations:
            if first_found_original == None:
                first_found_original = original
                the_same_originals_translations = [translation]
                if note:
                    notes = [note]
                else:
                    notes = []
                
                continue
            
            if original == first_found_original:
                the_same_originals_translations.append(translation)
                if note:
                    notes.append(note)
            else:
                the_same_originals_translations = [encode_for_locale(t) for t in the_same_originals_translations]
                the_same_originals_translations.sort(cmp=locale.strcoll)
                
                orig = first_found_original
                notes_str = ''.join(set(notes))
                
                joined_translations.append((orig, decode_to_utf(', '.join(the_same_originals_translations)) + notes_str.encode('utf-8')))
                
                first_found_original = original
                the_same_originals_translations = [translation]
                if note:
                    notes = [note]
                else:
                    notes = []
        
        if first_found_original != None:
            the_same_originals_translations = [encode_for_locale(t) for t in the_same_originals_translations]
            the_same_originals_translations.sort(cmp=locale.strcoll)
            
            orig = first_found_original
            notes_str = ''.join(set(notes))
            
            joined_translations.append((orig, decode_to_utf(', '.join(the_same_originals_translations)) + notes_str.encode('utf-8')))
        
        dict_per_first_letters[first_letter] = joined_translations
                

def main():
    f = open('../dict.txt')
    dict_per_first_letters = {}
    for line in f:
        line = line.decode('utf-8')
        match = DICT_LINE_RE.match(line)
        if match:
            original, translations = match.groups()
            
            for translation in translations.split(', '):
                translation = translation.strip()
                
                first_letter = None
                if translation.upper().startswith('CH'):
                    first_letter = 'CH'
                else:
                    first_letter = translation.upper()[0]
                
                note = ''
                if '(' in translation and '(0,5l)' not in translation:
                    translation, note = translation.split('(', 1)
                    translation = translation.strip()
                    note = '; (' + note.strip()
                    
                
                dict_per_first_letters.setdefault(encode_for_locale(first_letter), []) \
                    .append(((encode_for_locale(translation), note), original))
        # else:
        #     print line.encode('utf-8'),
    
    sorted_first_letters = dict_per_first_letters.keys()
    sorted_first_letters.sort(cmp=locale.strcoll)
    
    sort_words_and_join_the_same_words_and_move_notes_to_traslations(dict_per_first_letters)
    
    for first_letter in sorted_first_letters:
        print decode_to_utf(first_letter)
        
        for original, translation in dict_per_first_letters[first_letter]:
            print '    %s ~ %s' % (decode_to_utf(original), translation)
            # if len(original) > 30:
            #     print decode_to_utf(original)

if __name__ == '__main__':
    main()