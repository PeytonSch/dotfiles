print 'sourcing environment...'
source ./environment/env.nu
source ./environment/protected/env.nu

print 'Extracting paths'
# TODO: error handling for asserting some env vars are defined? 

let nvimPath = $'C:/Users/($env.MY_DEV_ENV.USER)/AppData/Local/'


let gitNuConfig = $'($env.MY_DEV_ENV.DOTFILES)/nushell/nushell/config.nu'
let gitNvimConfig = $'($env.MY_DEV_ENV.DOTFILES)/nvim'

print 'Copying...'
print $gitNuConfig
let srcCommand = $'cp ($gitNuConfig) ($nu.config-path)'
nu -c $srcCommand

print $gitNvimConfig
let nvimCmd = $'cp --recursive ($gitNvimConfig) ($nvimPath)'
nu -c $nvimCmd

# TODO: remove when I have my problems solved
let temp = $'cp C:\Users\K160722\Documents\dotfiles\nushell\nushell\protected\config.nu ($nu.config-path)'
nu -c $temp

print 'sourcing...'
source $nu.config-path
