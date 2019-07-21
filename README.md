Small tool that shifts SubStation Alpha Files(.ass) a specified number of frames forward/backwards.

Requirements: 
- OS: Windows, Linux
- Lua 5.x 

Windows: 
https://github.com/rjpcomputing/luaforwindows/releases

Linux:
- $ sudo apt install lua5.3	                		#Debian/Ubuntu systems 
- # yum install epel-release && yum install lua		#RHEL/CentOS systems 
- # dnf install lua		                			#Fedora 22+

How to use:

Windows:
1. Drag and drop .ass file on shift.bat / 
2. Enter framerate
3. Enter +/- frames you want to shift
4. Shifted "out.ass" file will be written in the folder containing the script

Linux:
1. From Terminal: $lua script.lua <subtitle file>
2. Enter framerate
3. Enter +/- frames you want to shift
4. Shifted "out.ass" file will be written in the folder containing the script

This project is licensed under the terms of the MIT license.
