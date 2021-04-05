--
-- xmobar config file
--

Config { font = "xft:Iosevka Nerd Font:style=:Bold,Regular:size=14:antialias=true" -- default font for xmobar
       , additionalFonts = [ "xft:Ubuntu Nerd Font:size=12:style=Bold:antialias=true" ] -- list of extra fonts to use below if desired
       , borderColor = "#27212e" -- color of border for xmobar, I set it to same as bgColor
       , border = TopB -- location of xmobar border
       , bgColor = "#27212e" -- default background color of bar
       , fgColor = "#e0dfe1" -- default text color used in the bar
       , alpha = 255 -- transparency, 255 is fully opaque, 0 fully transparent
       , position = TopW L 85 -- location on screen of the bar
       , textOffset = -1
       , iconOffset = -1 
       , lowerOnStart = False -- don't put xmobar into the xmonad window stack, keep it separate
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False -- don't hide xmobar on xmonad startup
       , iconRoot = "."
       , allDesktops = False -- show on all desktops by default, though I have to run two xmobar instances to get this to work
       , overrideRedirect = True
       -- commands are the commands displayed in your xmobar, see xmobar.org or `man xmobar`
       -- for all available details. here's the main ones I am using below:
       -- -t flag lets you use a template string for the command
       -- -H defines what the value of a high threshold is
       -- -h defines the color for when the command excedes the threshold set by -H
       -- <fc=#......></fc> is short for font color, allows you to wrap a string with a color of your choice
       , commands = [ 
                    -- Used to accept workspaces and layout details from xmonad itself
                    Run StdinReader
                    ]
       , sepChar = "%" -- character used to denote commands in the template below
       , alignSep = "}{" -- characters to denote where the bar is split between left, center, and right parts in the template below
       -- format to use for xmobar, using commands from above
       , template = " %StdinReader% }{"
       }
