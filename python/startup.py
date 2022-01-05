# based on https://unix.stackexchange.com/a/121390

import atexit
import os
from pathlib import Path
import readline

cache_dir = os.environ['XDG_CACHE_HOME']
if cache_dir:
    cache_dir = Path(cache_dir, 'python')
else:
    cache_dir = Path('~', '.python')
cache_dir.mkdir(parents=True, exist_ok=True)
histfile = cache_dir / 'history'

try:
    readline.read_history_file(histfile)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)

