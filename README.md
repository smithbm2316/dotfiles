# dotfiles

```sh
# TLDR: here's the command you need to install everything now
stow -vt ~/.config dotfiles
ln -s $HOME/dotfiles/.npmrc $HOME/.npmrc
# can also use the following alias to run the above command:
dotsup
```

The are my personal configuration files, feel free to steal anything you find interesting! I tend to update them relatively regularly with new apps or settings I add. The most interesting/useful dotfiles I probably have are my neovim config, my various window manager dotfiles (awesomewm, i3, spectrwm, and xmonad folders; I use awesomewm at the moment), and how I actually set up my dotfiles (I use a cli program called **gnu stow**, but I use it a bit differently than most tutorials online, I'll explain that process below). If you have any questions feel free to open an issue and answer the best that I can!


## How I setup and manage these files

### My old setup

As I mentioned above, I use a program called **gnu stow** to set up and manage my dotfiles. However, the way I came around to using it is a bit different than almost every _"manage your dotfiles with stow"_ tutorial that I found on Youtube or in blog posts online. I didn't really like how most people used it, as I had already been managing my dotfiles directly in my XDG_CONFIG_HOME directory (~/.config for me), which was a bit of a mess. You have two options doing that: write a _.gitignore_ that you have to edit **every** time you install a new program that adds a config directory/files to your XDG_CONFIG_HOME, which would be a nightmare for me with how much I try out new tools and programs. My XDG_CONFIG_HOME gets pretty messy bloated pretty quickly, so that wasn't a good option for me. The second option (and the option I used for months) is to automatically **ignore everything** in your _.gitignore_, and then manually edit it every time you have new config files you want to track and keep under version control. This also gets messy, as I had a _71 line long_ .gitignore. Yuck. I finally switched to a better method recently and am loving it much more now.

### My new setup with git + stow

Basically, I now keep this repo cloned to my home directory (~/dotfiles), and use a program called **gnu stow** to symlink all of the folders in this repo to my XDG_CONFIG_HOME directory. To get my dotfiles installed onto a new machine, all I have to do is `git clone https://github.com/smithbm2316/dotfiles ~/dotfiles`, and then run `stow -v -t ~/.config dotfiles`. Since I'm symlinking the _folders_ and not each individual file, what that means is that I can update the files in the appropriate folder in either my `~/dotfiles` directory or `~/.config` directory, keep my environment variable of `XDG_CONFIG_HOME` still set to `~/.config`, and all the apps on my system treat my dotfiles like they're in the `~/.config` folder. Magic! I don't have to continually maintain a super ugly `.gitignore` file in my `~/.config` directory, and to add any new program's dotfiles to my dotfiles repo, all I do is move that folder with `mv ~/.config/new-program-to-track ~/dotfiles/new-program-to-track`, change directory to my home folder with `cd`, and re-run `stow -v -t ~/.config dotfiles`, and I'm done! Stow is smart enough to realize that it already has symlinked the rest of the folders in my dotfiles repo to `~/.config`, and it will only symlink the newly added directory. I'm currently working on a Makefile to make this process even easier, and hopefully will have that done soon to make this setup even simpler!
