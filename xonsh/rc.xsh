
from __future__ import annotations

class __XonshRc:
    import pathlib
    import sys
    import typing

    # Allow loading local python modules.
    sys.path.insert(0, '')

    class Plugins:
        import shutil

        class PythonVersions:
            # `pyenv` integration.
            xontrib load pyenv
        class VirtualEnvironments:
            # Automatically load virtual environments.
            xontrib load autovox
            # Virtual environment management.
            xontrib load vox

            # Create virtual environments locally.
            $VIRTUALENV_HOME = '.'

            @events.autovox_policy
            def dotenv_policy(path: pathlib.Path, **_) -> None:
                """Load `./.venv` automatically."""
                venv = path / '.venv'
                if venv.exists():
                    return venv

        if shutil.which('zoxide'):
            execx($(zoxide init xonsh --cmd k), 'exec', __xonsh__.ctx, filename='zoxide')

    class Prompt:
        class Git:
            # Customize Git status display.
            for segment, prefix in {
                'branch': ' {CYAN}',
                'behind': '{CYAN}↓',
                'ahead': '{CYAN}↑',
                'stash_count': '{CYAN}*',
                'operations': '{RED}',
                'conflicts': '{RED}~',
                'staged': '{YELLOW}+',
                'changed': '{YELLOW}!',
                'untracked': '{BLUE}?',
            }.items():
                $PROMPT_FIELDS['gitstatus.' + segment].prefix = prefix
                $PROMPT_FIELDS['gitstatus.' + segment].suffix = ' '
            $PROMPT_FIELDS['gitstatus'].fragments = (
                '.branch',
                '.behind',
                '.ahead',
                '.stash_count',
                '.operations',
                '.conflicts',
                '.staged',
                '.changed',
                '.untracked',
            )

        class VirtualEnvironments:
            import os
            $PROMPT_FIELDS['env_prefix'] = ''
            $PROMPT_FIELDS['env_postfix'] = ''
            @events.vox_on_activate
            def set_env_name(name: str, path: pathlib.Path):
                $PROMPT_FIELDS['env_name'] = $PROMPT_FIELDS['env_prefix'] + os.path.basename(name) + $PROMPT_FIELDS['env_postfix']
            @events.vox_on_deactivate
            def unset_env_name(name: str, path: pathlib.Path):
                $PROMPT_FIELDS['env_name'] = None
            $PROMPT_FIELDS['env_name'] = None

        class TimeTaken:
            from datetime import datetime, timedelta
            # Time when last command was executed.
            last_time: datetime = datetime.now()
            # Delimiter for units.
            DELIMITER = ' '
            # Suffixes for units.
            SUFFIXES = ('d', 'h', 'm', 's')

            @events.on_postcommand
            def update_time_taken(cmd: str, rtn: int, out: str | None, ts: typing.List) -> None:
                """Update the time taken to run the last command."""
                hours: int; minutes: int; seconds: int = int(ts[1] - ts[0])
                minutes, seconds = seconds // 60, seconds % 60
                hours, minutes = minutes // 60, minutes % 60
                $PROMPT_FIELDS['time_taken'] = ' '.join([
                    str(value) + unit for value, unit in zip((
                        hours // 24, hours % 24, minutes, seconds,
                    ), (
                        'd', 'h', 'm', 's',
                    )) if value > 0
                ])
            $PROMPT_FIELDS['time_taken'] = ''
        
        class SenaryTime:
            import shutil
            if shutil.which('rn'):
                $PROMPT_FIELDS['senary_time'] = $(rn -ls).rstrip('\n')
            else:
                $PROMPT_FIELDS['senary_time'] = ''

        $PROMPT = '{RED}{last_return_code}{RESET} ' \
            '[{CYAN}蟒 {env_name:{} }{GREEN}{short_cwd}{RESET}] ' \
            '{branch_color}{gitstatus}' \
            '{BLUE}{prompt_end} {RESET}'
        $RIGHT_PROMPT = '{YELLOW}{time_taken} {RESET}{senary_time} '
        $BOTTOM_TOOLBAR = '{GREEN}{user}{YELLOW}@{GREEN}{hostname} {RESET}{cwd} '

        # Do not the reverse colors of the bottom toolbar.
        $XONSH_STYLE_OVERRIDES['bottom-toolbar'] = 'noreverse'

    class Aliases:
        import shutil

        aliases['ls'] = 'ls -GFh'
        aliases['la'] = 'ls -a'
        aliases['ll'] = '-al'
        if shutil.which('exa'):
            aliases['exa'] = 'exa -Fb'
            aliases['ls'] = 'exa --group-directories-first --ignore-glob=Icon\r'
            aliases['li'] = 'ls --git-ignore'
            aliases['ll'] = 'ls -lah --git'
            aliases['lg'] = 'ls -laGh --git'
            aliases['tree'] = 'exa --tree'
            aliases['desc'] = 'ls -dlbghH@ --git'

        if shutil.which('nvim'):
            aliases['vim8'] = shutil.which('vim')
            aliases['vim'] = shutil.which('nvim')
