#!/usr/bin/python
# -*- coding: utf-8 -*-
#
#
#
try:
    import logging
    import magic
    import os
    import codecs
except ImportError, e:
        print ''
        logging.error("please install packages that are not found!")
        print ''
        raise

BLOCKSIZE = 1048576 # or some other, desired size in bytes

allowed_ext = 'srt'
encoding_wanted = 'UTF-8'

current_directory = '.'
files = os.walk(current_directory)

for serieFold, serieSeason, serieFile in files:

    for file in serieFile :
        if file.endswith(allowed_ext):
            to_decode = os.path.join(serieFold, file)

            blob = open(to_decode).read()
            m = magic.open(magic.MAGIC_MIME_ENCODING)
            m.load()
            encoding = m.buffer(blob)
            print file

            try:
                with codecs.open(to_decode, "r", encoding) as to_decode:
                    with codecs.open(to_decode, "w", encoding_wanted) as converted:
                        while True:
                            contents = to_decode.read(BLOCKSIZE)
                            if not contents:
                                break
                                print converted
                                #converted.write(contents)
            except LookupError, e:
                logging.error(" file not converted, unkown type : " + file)