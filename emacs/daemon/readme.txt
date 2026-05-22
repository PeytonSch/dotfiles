This is the setup for the daemon on windows which lets doom run as a background process to come up instantly.

The script needs to point to your emacs bin / run exe and then create a shortcut (Should be able to copy the one here) for it and put it in your windows user startup folder (win+r then shell:startup)


Then, you need to setup the client launcher (what will launch the emacs window attached to the daemon that is running)

Create a new bat file with your path:

@off
start "" "/path/to/emacsclientw.exe" -c -n -a ""


Optionally create a shortcut as well

Create a new shortcut with /path/to/emacsclientw.exe -c -n -a ""

-c = new window 
-n = no wait 
-a "" = anternate editor, it being "" forces it to launch a new daemon on crash


I have this shortcut as doom in this dir right now. Add to path and have fun! (right now need to type doom.lnk not just doom...)
