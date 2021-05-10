import os
import sys

file_input = False
if len(sys.argv) > 1:
    input_file = open(sys.argv[1], "r")
    file_input = True

print("welcome to Provost's Python text reader")
print("You can use this text reader to read files (in your directory only)!")
print("You are not supposed to view other directories!!")

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
        
        print("Contents of", filename, "file are:\n")
        print(contents)

print("This program is vulnerable as you could access any file in the server using it")