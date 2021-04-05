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
       , position = Top -- location on screen of the bar
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
                    -- better than normal Weather command, allows for substitution of skyCondition with icons easily
                    -- accepts a weather station code to ping, list of skyConditions (all of the possible conditions
                    -- are listed below) and the corresponding unicode icon for them (check out nerdfonts.com for
                    -- picking your icons and installing a font that supports the icons used below), then the normal
                    -- flags. note: use `skyConditionS` instead of `skyCondition` which is used in the normal Weather
                    -- command, so that xmobar can replace the skyConditionS with the appropriate icon
                    -- https://tgftp.nws.noaa.gov/weather/current/KCCR.html
                      Run WeatherX "KCCR" [ ("clear", "<fc=#f97e72>滛 </fc>")
                                          , ("sunny", "<fc=#f97e72>履 </fc>")
                                          , ("mostly clear", "<fc=#ffe261>滋 </fc>")
                                          , ("mostly sunny", "<fc=#ffe261>滋 </fc>")
                                          , ("partly sunny", "<fc=#ffe261>杖 </fc>")
                                          , ("fair", "<fc=#ffe261>滛 </fc>")
                                          , ("cloudy","<fc=#91889b>摒 </fc>")
                                          , ("overcast","<fc=#91889b>摒 </fc>")
                                          , ("partly cloudy", "<fc=#91889b>杖 </fc>")
                                          , ("mostly cloudy", "<fc=#40b4c4>殺 </fc>")
                                          , ("considerable cloudiness", "<fc=#40b4c4>ﭼ  </fc>")]
                                          [ "-t", "<skyConditionS> <tempF>°" ] 18000
                    -- Network status, <rx> returns KBs down, <tx>returns KBs up
                    , Run DynNetwork [ "-t", "<fc=#74dfc4>\xf0ab </fc><rx> <fc=#74dfc4>\xf0aa </fc><tx>"] 10
                    -- Checks cpu usage, <total> returns the percent of the cpu currently in use
                    , Run Cpu ["-t", "<fc=#b381c5> </fc><total>%", "-H", "69", "-h", "#f95e94" ] 10
                    -- Checks RAM usage, <usedratio> returns the percent of memory currently in use
                    , Run Memory ["-t", "<fc=#f97e72>  </fc><usedratio>%", "-H", "69", "-h", "#f95e94" ] 10
                    -- Runs the `date` unix command with the given format, see `man date` for formatting options
                    , Run Date "<fc=#eb64b9> </fc> %a %b %d, %I:%M%P " "date" 50
                    -- My custom bash script for showing current pulseaudio volume and mute state, requires package `pulsemixer` on debian
                    , Run Com "/bin/bash" [ "-c", "~/.config/xmonad/scripts/pulsemixer-status.sh" ] "pavolume" 1
                    -- Mpris2 module, uses spotify to get its data from
                    , Run Mpris2 "spotify" [ "-t", "<fc=#74dfc4><title> - <artist></fc>" ] 10
                    -- Used to accept workspaces and layout details from xmonad itself
                    , Run StdinReader
                    ]
       , sepChar = "%" -- character used to denote commands in the template below
       , alignSep = "}{" -- characters to denote where the bar is split between left, center, and right parts in the template below
       -- format to use for xmobar, using commands from above
       , template = " %StdinReader% } %mpris2% { %dynnetwork% | %KCCR% | %pavolume% | %cpu% | %memory% | %date%"
       }
