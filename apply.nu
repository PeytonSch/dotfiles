print 'sourcing environment...'
source ./environment/env.nu
source ./environment/protected/env.nu

print 'Extracting paths'
# TODO: error handling for asserting some env vars are defined? 
let gitNuConfig = $'($env.MY_DEV_ENV.DOTFILES)/nushell/nushell/config.nu'

print 'Copying...'
print $gitNuConfig
let srcCommand = $'cp ($gitNuConfig) ($nu.config-path)'

nu -c $srcCommand

print 'sourcing...'
source $nu.config-path
