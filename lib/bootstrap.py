# Library for bootstrap scripts.

import os

home = os.path.expanduser("~")

# Help Python 2.x be compatible with Python 3.x
try: input = raw_input
except NameError: pass

def ensure_link(dotdir, src, dst):
    src = os.path.join(dotdir, src)
    dst = os.path.join(home, dst)

    if not os.path.islink(dst) and os.path.exists(dst):
        print("The destination for a symbolic link already exists.")
        print("Path: {0}".format(dst))
        choice = input("Would you like to overwrite it? (Y/n): ")
        if choice == 'Y' or choice == 'y':
            if os.path.isdir(dst):
                os.rmdir(dst)
            else:
                os.remove(dst)

    if not os.path.islink(dst) and not os.path.exists(dst):
        os.symlink(src, dst)


def ensure_dir(path):
    path = os.path.join(home, path)

    if not os.path.isdir(path):
        os.makedirs(path)


def link_set(dotdir, dotfileset):
    for item in dotfileset:
        ensure_link(dotdir, item[0], item[1])


def create_dir_set(dirset):
    for item in dirset:
        ensure_dir(item)


