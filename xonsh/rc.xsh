
## Plugins ##

# Load plugins.
xontrib load autovox
xontrib load pyenv
xontrib load vox

# Make local virtual environments.
$VIRTUALENV_HOME = '.'
# Automatically load virtual environments.
@events.autovox_policy
def dotenv_policy(path, **_):
    venv = path / '.venv'
    if venv.exists():
        return venv

execx($(zoxide init xonsh --cmd k), 'exec', __xonsh__.ctx, filename='zoxide')

## Prompt ##

# Customize the git status prompt.
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
def __env_name():
    try:
        return os.path.basename($VIRTUAL_ENV)
    except:
        return None
$PROMPT_FIELDS['env_name'] = __env_name


$PROMPT = '{RED}{last_return_code}{RESET} ' \
    '[{CYAN}蟒 {env_name:{} }{GREEN}{short_cwd}{RESET}] ' \
    '{branch_color}{gitstatus}' \
    '{BLUE}{prompt_end} {RESET}'
$XONSH_STYLE_OVERRIDES['bottom-toolbar'] = 'noreverse'
$BOTTOM_TOOLBAR = '{GREEN}{user}{YELLOW}@{GREEN}{hostname} {RESET}{cwd} '


# Allow loading local python modules.
sys.path.insert(0, '')

## Aliases ##
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
