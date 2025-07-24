# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# Use nvim as nu editor 
$env.config.buffer_editor = "nvim"


# load my env stuff
let s1 = $'source ($env.MY_DEV_ENV.DOTFILES)/nushell/nu-tokyo-night-theme.nu'
let s2 = $'source ($env.MY_DEV_ENV.DOTFILES)/nushell/fd.nu'
let s3 = $'source ($env.MY_DEV_ENV.DOTFILES)/nushell/link.nu'

nu -c $s1
nu -c $s2
nu -c $s3

$env.config.keybindings = [
{
name: fzf_change_dir
          modifier: CONTROL
          keycode: Char_f
          mode: [emacs vi_normal vi_insert]
          event: {
send: executehostcommand,
          cmd: "fd"
          }
},
]



# Fix scrolling terminal while typing in windows by setting this to false:
# See: https://github.com/nushell/nushell/issues/5585#issuecomment-2614233472
$env.config.shell_integration.osc133 = false

# vi mode
$env.config.edit_mode = 'vi'

# Starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# alias
alias ij = idea64.exe
