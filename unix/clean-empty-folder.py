 #!/usr/bin/python
 # -*- coding: utf-8 -*-

import os
import shutil

allowed_ext = ['mp4', 'avi', 'mkv', 'mov', 'part']
delete_directory = []

current_directory = '.'
for child in os.listdir(current_directory):
    ep_directory = os.path.join(current_directory, child)
    if os.path.isdir(ep_directory):
		print ep_directory
		has_ep = False
		# Do stuff to the directory "test_path"
		for file in os.listdir(ep_directory):
			print " - " + file
			filename, file_extension = os.path.splitext(file)
			if file_extension in allowed_ext:
				has_ep = True
				
		if not has_ep:
			delete_directory.append(ep_directory);
			

for dir in delete_directory:
	print dir

confirm = raw_input("Do you want to delete those folders ? [y = Yes/n = No]").lower()

if confirm == "y" :
	for dir in delete_directory:
		shutil.rmtree(dir)

print "Done"
