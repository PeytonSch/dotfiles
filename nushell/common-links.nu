use std log

def main [
        mode: string # one of link or file protocol (link | file)
    ] {

    if ($mode != 'link' and $mode != 'file') {
        log error $"Mode must be link or file, got ($mode)"
        return
    }
    log info $"Link with ($mode) mode"

    # get list of common packages
    let cmd = $'cd C:\Users\($env.MY_DEV_ENV.USER)\Documents\repos\common-ts\packages'
    nu -c cmd

    let packages = ls -l | where type == dir | get name

    log info $"Got packages ($packages)"
    mut packageNames = []

    # link and return list of package names to then link to
    for e in $packages {
    # $packages | each { |e|
        log info $"handling ($e)"
        cd $e
        let pwd = pwd
        # log info $"now in ($pwd)"
        if ($mode == 'link') {
            log info "Linking..."
            pnpm link -g
            log info "Done"
        }
        let packageName = open package.json | select name
        $packageNames = $packageNames | append $packageName
        cd ..
    }

    log info $"Finished linking package names ($packageNames)"

    # go to cgsweb and get packages cgsweb uses

    cd C:\Users\K160722\Documents\repos\cgsweb

    let package = open package.json
    let deps = $package.dependencies | merge $package.devDependencies | to text

    log info $"Extracted deps ($deps)"

    for e in $packageNames {
        let name = $e | get name
        let dir = $name | split column "/" | get column2 | to text
        let contains = $deps | str contains $name
        if $contains == true {
            if ($mode == 'link') {
                log info $"Linking ($e)"
                pnpm link -g $name
            }
            if ($mode == 'file') {
                let path = $"file:C:\\Users\\($env.MY_DEV_ENV.USER)\\Documents\\repos\\common-ts\\packages\\($dir)" | to text
                log info $"path: ($path)"
                # need to format command all as one string
                let strCommand = $"pnpm add ($path)"
                nu -c $strCommand
            }
        } else {
            log info $"Project does not contain dep ($name)"
        }
    }

}
