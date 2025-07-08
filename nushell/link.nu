use std log

# A command to pnpm link the package in the current working directory to a target project.
export def "dep link" [ 
        target: string # The target project. One of: cgsweb | map
        --name (-n): string # Name of the package. Defaults to working dir. Ex: @cgsweb/core
        --do-remove (-x): string # Perform the pnpm remove step in the target project.
        --start (-s) # Start the dev server after changing the package
        --build (-b) # Build current project
    ] {
        # if (($do_remove) and ($name == null)) {
        #     error make {
        #         msg: "--name (-n) must be specified for package to remove in --do-remove (-x)"
        #         label: {
        #             text: "Require --name",
        #             span: (metadata $do_remove).span
        #         }
        #     }
        # }
        let currentProj = pwd

        if $build {
            log info "Building Project..."
            pnpm build
        }
        # Move to the target project.
        match $target {
            "map" => { 
                cd C:\Users\K160722\Documents\repos\map
            }
            "cgsweb" => {
                cd C:\Users\K160722\Documents\repos\cgsweb
            }
            _ => {
                error make {
                    msg: "target must be one of: map | cgsweb"
                    label: {
                        text: "target must be one of: map | cgsweb",
                    }
                }
            }
        }
        let wd = pwd
        if $do_remove != null {
            log info $"Removing package ($do_remove)"
            pnpm remove $do_remove
        }
        if $name != null {
            log info $"Adding file:($name)"
            pnpm add -w file:($name)
        } else {
            log info $"Adding file:($currentProj)"
            pnpm add -w file:($currentProj)
        }
        log info "Done with add"

        if $start {
            log info $"Starting dev server for ($target)"
            match $target {
            "map" => { 
                pnpm start
            }
            "cgsweb" => {
                pnpm run dev
            }

            }
        }
}

