#!/usr/bin/env /usr/local/bin/python

import os
from pyfileinfo import PyFileInfo


def main():
    for file in PyFileInfo('/data').files_in(recursive=True):
        permission = oct(os.stat(file.path).st_mode & 0o777)
        if file.is_directory() and permission != '0o775':
            os.chmod(file.path, 0o775)
        elif not file.is_directory() and permission != '0o664':
            os.chmod(file.path, 0o664)


if __name__ == '__main__':
    main()
