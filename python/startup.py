# Store interactive history in `$XDG_STATE_HOME/python/history` instead of
# `~/.python_history`.
def enablerlcompleter():
    """Enable default readline configuration on interactive prompts, by
    registering a sys.__interactivehook__.
    If the readline module can be imported, the hook will set the Tab key
    as completion key and register ~/.python_history as history file.
    This can be overridden in the sitecustomize or usercustomize module,
    or in a PYTHONSTARTUP file.
    """

    import os
    import sys

    def register_readline():
        import atexit
        try:
            import readline
            import rlcompleter
        except ImportError:
            return

        # Reading the initialization (config) file may not be enough to set a
        # completion key, so we set one first and then read the file.
        readline_doc = getattr(readline, '__doc__', '')
        if readline_doc is not None and 'libedit' in readline_doc:
            readline.parse_and_bind('bind ^I rl_complete')
        else:
            readline.parse_and_bind('tab: complete')

        try:
            readline.read_init_file()
        except OSError:
            # An OSError here could have many causes, but the most likely one
            # is that there's no .inputrc file (or .editrc file in the case of
            # Mac OS X + libedit) in the expected location.  In that case, we
            # want to ignore the exception.
            pass

        if readline.get_current_history_length() == 0:
            # If no history was loaded, default to .python_history.
            # The guard is necessary to avoid doubling history size at
            # each interpreter exit when readline was already configured
            # through a PYTHONSTARTUP hook, see:
            # http://bugs.python.org/issue5845#msg198636

            # history = os.path.join(os.path.expanduser('~'),
            #                        '.python_history')

            # Based on https://bugs.python.org/msg318437
            history = os.path.join(os.path.expanduser(
                os.environ.get('XDG_STATE_HOME', '~')), 'python', 'history')

            try:
                readline.read_history_file(history)
            except OSError:
                pass
            atexit.register(readline.write_history_file, history)

    sys.__interactivehook__ = register_readline


enablerlcompleter()
del enablerlcompleter
