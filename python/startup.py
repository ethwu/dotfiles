# https://unix.stackexchange.com/a/121390
import atexit
import os
import readline

cache_dir = os.environ['XDG_CACHE_HOME']
if cache_dir is None:
    cache_dir = os.path.expanduser('-')
histfile = os.path.join(cache_dir, 'python', 'python_history')

try:
    readline.read_history_file(histfile)
    readline.set_history_length(0)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)

