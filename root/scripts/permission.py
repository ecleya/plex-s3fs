#!/usr/bin/env /usr/local/bin/python

import os


def files_in(path):
    files = [os.path.join(path, filename)
             for filename in os.listdir(path) if filename[0] != '.']
    files.sort()

    for file in files:
        yield file
        if os.path.isdir(file):
            yield from files_in(file)


def main():
    for file in files_in('/data'):
        permission = oct(os.stat(file).st_mode & 0o777)
        if os.path.isdir(file) and permission != '0o775':
            os.chmod(file, 0o775)
        elif not os.path.isdir(file) and permission != '0o664':
            os.chmod(file, 0o664)


if __name__ == '__main__':
    main()
