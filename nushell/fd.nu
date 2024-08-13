use std log

# --env lets us change the pwd env variable outside of the lifetime of this function
export def --env fd [] {
    let selectedString = ls -af ~/ C:\Users\K160722\Documents C:\Users\K160722\Documents\repos C:\Users\K160722\AppData\Local | get name | to text | fzf
    cd $selectedString
}

