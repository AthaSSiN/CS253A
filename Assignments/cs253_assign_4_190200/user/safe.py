import os
import sys
import re

file_input = False

if len(sys.argv) > 1:
    input_file = open(sys.argv[1], "r")
    file_input = True

def clean(f): # Function to clean the input path

    f = "./" + f
    
    temp = f
    temp = re.sub('\.\./', '', temp)

    if temp != f:
        print("Cleaned path by regex:", temp)
    
    i = 0
    for j in range(len(f) - 2):
        if f[i:i+3] == "../" or f[i:i+3] == "..\\":
            f = f[:i] + f[i+3:]
            i = max(-1, i - 3)
        i += 1

    if f != temp:
        print("But I am a smarter hack detector")
        print("Cleaned path by me:", f)

    return f


print("welcome to Provost's Python text reader")
print("You can use this text reader to read files (in your directory only)!")
print("It is not possible to view other directories!!")

while 1:
    print('\nEnter 1 to list files in a directory\nEnter 2 to view files\nAnything else to quit:\nEnter Input: ')
    if file_input:
        inp = input_file.readline().strip()
        print(inp)
    else:
        inp = input()

    if inp != '1' and inp != '2':
        break
    
    print('\nEnter path to file relative to your user directory: ')
    if file_input:
        filename = input_file.readline().strip()
        print(filename)
    else:
        filename = input()

    filename = clean(filename) # clean input path
    if inp == '1':
        try:
            lst = os.listdir(filename)
        except FileNotFoundError:
            print("Folder", filename, "not found")
            continue
        except NotADirectoryError:
            print(filename, " is a file")
            continue

        print("Contents of", filename, "folder are:\n")
        for f in lst:
            print(f)
    else:
        try:
            fil = open(filename, 'r')
            contents = fil.read()
            fil.close()
        except FileNotFoundError:
            print("File", filename, "not found")
            continue
        except IsADirectoryError:
            print(filename, " is a folder")
            continue
        
        print("Contents of", filename, "file are:\n")
        print(contents)

print("This program is safe for the server, no files outside the folder could be viewed!")