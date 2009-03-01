#!/usr/bin/env python
# -*- coding: utf-8 -*-

from xml.sax.saxutils import XMLGenerator

from StringIO import StringIO

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
    def __init__(self):
        stream = StringIO()

        self.xml = XMLGenerator(stream, 'UTF-8')
        self.xml.startDocument()
        self.xml.startElement('!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"', {})
        self.xml.ignorableWhitespace('\n')
        self.xml.startElement("plist", {"version" : "1.0"})
        self.xml.ignorableWhitespace('\n')
        self.xml.startElement("array", {})
        self.xml.ignorableWhitespace('\n')
        
        self.generate_sections()
        
        self.xml.endElement("array")
        self.xml.ignorableWhitespace('\n')
        self.xml.endElement("plist")

        stream.seek(0)
        print stream.read()
    
    def generate_sections(self):
        pass

if __name__ == '__main__':
    main()