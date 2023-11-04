$env.PROMPT_COMMAND = { || 
    [
        (ansi (match (is-admin) {
            true => 'red_bold',
            false => 'green_bold'
        }))
        '['
        $env.USER
        ']'
        (ansi reset)
        ' '
        ($env.PWD | str replace $env.HOME '~')
        ' '
    ] | str join
}

$env.PROMPT_COMMAND_RIGHT = { ||
    match $env.LAST_EXIT_CODE {
        0 => [],
        _ => [
            (ansi rb)
            $env.LAST_EXIT_CODE
            (ansi reset)
            ' '
        ]
    } | append [      
        (ansi magenta)
        (date now | format date '%m/%d/%Y %r')
        (ansi reset)        
    ] | str join
}

$env.PROMPT_INDICATOR = '> '
$env.PROMPT_INDICATOR_VI_INSERT = '> '
$env.PROMPT_INDICATOR_VI_NORMAL = ': '
$env.PROMPT_MULTILINE_INDICATOR = '::: '

$env.ENV_CONVERSIONS = {
    'PATH': {
        from_string: { |s| $s | split row (char esep) | path expand -n }
        to_string: { |v| $v | path expand -n | str join (char esep) }
    }
}

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

$env.PATH = ($env.PATH | append [
    '/opt/cuda/bin'
    '/opt/cuda/nsight_compute'
    '/opt/cuda/nsight_systems/bin'
    '~/.cargo/bin'
])

$env.EDITOR = 'helix'
$env.LESSHISTFILE = '-'
$env.CUDA_PATH = '/opt/cuda'

if 'WT_SESSION' in ($env | columns) {
    $env.COLORTERM = 'truecolor'
}
