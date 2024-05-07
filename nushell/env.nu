# Nushell Environment Config File
#
# version = "0.93.0"

# Predefined prompt segments.
module prompt_segment {
    # Get a prompt segment for the current working directory.
    export def working_directory [] {
        let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
            null => $env.PWD
            '' => '~'
            $relative_pwd => ([~ $relative_pwd] | path join)
        }
        let path_color = (if (is-admin) { ansi cyan_bold } else { ansi green_bold })
        let separator_color = (if (is-admin) { ansi light_cyan_bold } else { ansi light_green_bold })
        let path_segment = $"($path_color)($dir)"

        $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
    }

    # Get the time in magenta with green separators and am/pm underlined.
    export def time [] {
        ([
            (ansi reset)
            (ansi magenta)
            (date now | format date '%x %X') # try to respect user's locale
        ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
            str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")
    }

    # Get the duration of the last command in yellow.
    export def duration [] {
        let elapsed = $env.CMD_DURATION_MS | into int | into duration --unit ms
        $"(ansi reset)(ansi yellow)($elapsed)"
    }

    # Get the exit code of the last command.
    export def last_exit_code [] {
        let exit_code = $env.LAST_EXIT_CODE
        let color = if $exit_code == 0 { 'light_red' } else { 'light_red_bold' }
        $"(ansi reset)(ansi $color)($exit_code)"
    }

    # Get the history name in red.
    export def history_number [] {
        $"(ansi reset)(ansi light_red)(history | length)"
    }

    # Get the user and hostname in green, separated by a yellow `@`.
    export def userhost [] {
        $"(ansi reset)"
        ([
            (ansi reset) (ansi green_italic)
            ($env.USER)
            (ansi reset) (ansi yellow)
            '@'
            (ansi reset) (ansi green_italic)
            ($env.HOSTNAME)
        ] | str join)
    }
}

use prompt_segment

# Generate the left prompt.
def create_left_prompt [] {
    ([
        (prompt_segment last_exit_code)
        $"(ansi reset)[(prompt_segment working_directory)(ansi reset)]"
        (prompt_segment history_number)
    ] | str join (char space))
}

# Generate the right prompt.
def create_right_prompt [] {
    mut segments = [(prompt_segment duration)]
    if ('SSH_CLIENT' in $env or 'SSH_TTY' in $env) {
        $segments = ($segments | append (prompt_segment userhost))
    }
    $segments | str join (char space)
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| $" (ansi blue_bold)> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| $" (ansi blue_bold)> " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| $" (ansi green_bold)> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| $"(ansi blue_bold)::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

source ($nu.default-config-dir | path join "local/env.nu")
