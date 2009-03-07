#!/usr/bin/env python
# -*- coding: utf-8 -*-

from xml.sax.saxutils import XMLGenerator
from StringIO import StringIO
import sys

'''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
	<dict>
		<key>sectionData</key>
		<array>
			<dict>
				<key>orig</key>
				<string>aloše</string>
				<key>trans</key>
				<string>alimenty</string>
			</dict>
			<dict>
				<key>orig</key>
				<string>ance</string>
				<key>trans</key>
				<string>drobný mince</string>
			</dict>
		</array>
		<key>sectionName</key>
		<string>A</string>
	</dict>
</array>
</plist>
'''

class main(object):
    def __init__(self, f):
        stream = StringIO()
        
        self.input = f
        
        self.xml = XMLGenerator(stream, 'UTF-8')
        self.xml.startDocument()
        self.xml.startElement('!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"', {})
        self.xml.ignorableWhitespace('\n')
        self.xml.startElement("plist", {"version" : "1.0"})
        self.xml.ignorableWhitespace('\n')
        self.xml.startElement("array", {})
        # self.xml.ignorableWhitespace('\n')
        
        self.generate_sections()
        
        self.xml.ignorableWhitespace('\n')
        self.xml.endElement("array")
        self.xml.ignorableWhitespace('\n')
        self.xml.endElement("plist")
        
        from pprint import pprint
        # pprint(dir(self.xml))
        
        stream.seek(0)
        print stream.read()
    
    def generate_sections(self):
        section_name = None
        translation_pairs = []
        
        for line in self.input:
            if line.strip():
                if section_name is None:
                    section_name = line.strip()
                    continue
                
                if line.startswith(' '):
                    orig, trans = [s.strip() for s in line.split('~', 1)]
                    translation_pairs.append((orig, trans))
                else:
                    self.generate_section(section_name, translation_pairs)
                    section_name = line.strip()
                    translation_pairs = []
        
        if section_name:
            self.generate_section(section_name, translation_pairs)
    
    def generate_section(self, section_name, translation_pairs):
        self.indent(1)
        self.xml.startElement("dict", {})
        
        self.indent(2)
        self.xml.startElement("key", {})
        self.xml.characters('sectionData')
        self.xml.endElement("key")
        
        self.indent(2)
        self.xml.startElement("array", {})
        
        for orig, trans in translation_pairs:
            self.generate_translation_pair(orig, trans)
        
        self.indent(2)
        self.xml.endElement("array")
        
        self.indent(2)
        self.xml.startElement("key", {})
        self.xml.characters('sectionName')
        self.xml.endElement("key")
        
        self.indent(2)
        self.xml.startElement("string", {})
        self.xml.characters(section_name)
        self.xml.endElement("string")
        
        self.indent(1)
        self.xml.endElement('dict')
    
    def generate_translation_pair(self, orig, trans):
        self.indent(3)
        self.xml.startElement("dict", {})
        
        self.indent(4)
        self.xml.startElement("key", {})
        self.xml.characters('orig')
        self.xml.endElement("key")
        
        self.indent(4)
        self.xml.startElement("string", {})
        self.xml.characters(orig)
        self.xml.endElement("string")
        
        self.indent(4)
        self.xml.startElement("key", {})
        self.xml.characters('trans')
        self.xml.endElement("key")
        
        self.indent(4)
        self.xml.startElement("string", {})
        self.xml.characters(trans)
        self.xml.endElement("string")
        
        self.indent(3)
        self.xml.endElement("dict")
        
    
    def indent(self, level):
        self.xml.ignorableWhitespace('\n' + ' ' * 4 * level)
    
if __name__ == '__main__':
    if len(sys.argv) == 2 and sys.argv[1] == '-s':
        f = sys.stdin
    else:
        f = open('../dict.txt')
    main(f)
