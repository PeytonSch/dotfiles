use std log

# --env lets us change the pwd env variable outside of the lifetime of this function
export def --env fd [] {
    let selectedString = ls -af ~/ C:\Users\K160722\Documents C:\Users\K160722\Documents\repos C:\Users\K160722\AppData\Local | get name | to text | fzf
    cd $selectedString
}

# --env lets us change the pwd env variable outside of the lifetime of this function
export def --env opencgs [] {
    let selectedString = ls ...(glob C:/Users/K160722/Documents/repos/cgsweb/src/**/*.{ts,tsx}) | get name | to text | fzf
    webstorm $selectedString
}

# --env lets us change the pwd env variable outside of the lifetime of this function
export def --env opencgsmods [] {
    let selectedString = ls ...(glob C:/Users/K160722/Documents/repos/cgsweb/node_modules/@cgsweb/core/lib/components/**/*) | get name | to text | fzf
    webstorm $selectedString
}

# --env lets us change the pwd env variable outside of the lifetime of this function
export def --env openvideomods [] {
    let selectedString = ls ...(glob C:/Users/K160722/Documents/repos/video/node_modules/@cgsweb/core/lib/components/**/*) | get name | to text | fzf
    webstorm $selectedString
}


# --env lets us change the pwd env variable outside of the lifetime of this function
export def --env openmap [] {
    let selectedString = ls ...(glob C:/Users/K160722/Documents/repos/map/src/**/*.{ts,tsx}) | get name | to text | fzf
    webstorm $selectedString
}


# --env lets us change the pwd env variable outside of the lifetime of this function
export def --env opencommon [] {
    let selectedString = ls ...(glob C:/Users/K160722/Documents/repos/common-ts/**/*) | get name | to text | fzf
    webstorm $selectedString
}

# --env lets us change the pwd env variable outside of the lifetime of this function
export def --env opencore [] {
    let selectedString = ls ...(glob C:/Users/K160722/Documents/repos/common-ts/packages/core/**/*) | get name | to text | fzf
    webstorm $selectedString
}

# --env lets us change the pwd env variable outside of the lifetime of this function
# wses = web storm everything (es.exe)
export def --env wses [] {
    let selectedString = es.exe
    webstorm $selectedString
}
