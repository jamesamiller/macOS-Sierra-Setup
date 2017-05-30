# macOS 10.12 Sierra Setup

These instructions are for configuring a new install of macOS 10.12 Sierra, based on my research, teaching, scientific computing, and personal needs. My starting point was the macOS setup [here](https://gist.github.com/kevinelliott/7a152c556a83b322e0a8cd2df128235c), but I've drawn heavily upon a few other repositories, such as [dev-setup](https://github.com/donnemartin/dev-setup) and the famous [dotfiles](https://github.com/mathiasbynens/dotfiles). Also, [awesome-osx-command-line](https://github.com/herrbischoff/awesome-osx-command-line) has an extensive list of macOS shell commands that could be incorporated into a setup or aliased in a dot file.

You can modify these scripts to suit yourself. If you find it useful, please leave a comment and/or tell others about it.

## Basic macOS Preferences

First take care of some basic things through the System Preferences panel, such as 

- Mouse configuration (e.g., tracking speed, scrolling)
- Screen and Energy Saver options
- Dock size
- Finder preferences and layout
- Firewall
- Hostname

These can be set with command line instructions also, but require a restart in order to take effect.

## Install Software

The software described below is what I need on any macOS machine. Other miscellaneous software is local or relatively minor and can be installed on a case-by-case basis.

### Prerequisites

In order to do the software and utility installs, we need a couple of tools first:
- Xcode Command Line Tools
- [Homebrew](https://brew.sh/)
- [mas](https://github.com/mas-cli/mas), which is a great way to install things from the Mac App Store

These three items are handled by the script `prereq.sh`. Retrieve it with

`curl -o prereq.sh https://raw.githubusercontent.com/jamesamiller/macOS-Sierra-Setup/master/prereq.sh`

and then make it executable

`chmod u+x prereq.sh`

and run it

`./prereq.sh`

It ends asking you to sign into the App Store. You will need your App Store password for this. 

### Overview of Software Installation 

We can move on to installing packages and software. All binaries could be installed from a single script, but I prefer to install in chunks so I can address any issues (although there *shouldn't* be any) before they lead to other problems.

My current software installation procedure has four parts:

1. [Install Bash 4.x and some GNU utilities](#bash-and-gnu-utilities)
2. [Install applications that have Homebrew/Cask formulae](#macos-applications) 
3. [Install items from the Mac App Store](#mac-app-store)
4. [Install applications that don't have Homebrew/Cask formulae](#misc-applications)

### Bash and GNU Utilities

Here we will install Bash 4 and many GNU command line tools using Homebrew. The install commands are in the bash script `gnu.sh`. Notably, we'll install the GNU `coreutils` and `findutils`, and use those instead of the BSD tools installed with macOS. 

Retrieve the Bash script 

`curl -o gnu.sh https://raw.githubusercontent.com/jamesamiller/macOS-Sierra-Setup/master/gnu.sh`

and edit it for any last-minute changes. Now make it executable 

`chmod u+x gnu.sh`

and run it

`./gnu.sh`

#### Post Install

We want to use the GNU `coreutils` and `findutils` with their usual names (and not with the "g" prefix). The Homebrew coreutils install creates a directory `$(brew --prefix coreutils)/libexec/gnubin` that contains the usual names sym linked to the GNU "g"-prefixed ones in `$(brew --prefix coreutils)/bin`.

We thus need to be sure that `$(brew --prefix coreutils)/libexec/gnubin` is in PATH before the directory that contains the default BSD macOS versions. The same argument goes for `findutils`.

This is accomplished with the following lines in my `.path` file, which in turn is called by my `.bash_profile`. 

```bash
# Reference GNU utilities without the 'g' prefix
export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix findutils)/libexec/gnuman:$MANPATH"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
```

My dotfiles are loaded  later, and so the above commands should only be entered now if is necessary to immediately use the GNU utilities (which it shouldn't be).

### macOS Applications

Applications available as Homebrew formulae include Google Chrome, 1Password, Dropbox, Sublime Text, and iTerm.

Retrieve the script `apps.sh`

`curl -o apps.sh https://raw.githubusercontent.com/jamesamiller/macOS-Sierra-Setup/master/apps.sh`

and edit for any additions or deletions. Make the script executable and run it.


This may take a while, but it's much faster than the manual method of searching and clicking for all these apps!

#### Post Install

Most of these apps require a sign-in. This can be done now or later. At the very least, I need to sign in to 1password, since I don't know my passwords! 

Signing into Dropbox or Google Drive, for example, will initiate the download of all its contents, and that will take a while. 

Since an updated Ruby was installed, let's go ahead and install what we need for Jekyll development:

```bash
gem install rubygems-update
gem install jekyll
```

### Mac App Store

These applications are installed with the bash script `mas.sh`.

Grab the script

`curl -o mas.sh https://raw.githubusercontent.com/jamesamiller/macOS-Sierra-Setup/master/mas.sh`

and as before review it and make any last-minute changes. Change permissions to make is executable and then run it. 

Again, this is the best way of installing applications, and beats having to root around the App Store and manually install each one.


### Misc Applications

- Office 2016 for Mac
- Mathematica
- Matlab
- MacTeX
- Camtasia
- CrashPlan
- GPG Suite
- Keybase
- Intel Compilers
- ScanSnap Tools

We can also defer these installs to later, unless we have them on a USB and can quickly do it now.

There will also be Adobe applications that we'll need through the Creative Cloud control panel, such as Acrobat, Photoshop, and Illustrator.

Utility and software installation is now done, but we need to configure bash and some other things.

# Dotfiles and More Preferences

## Bash

Clone my custom `.dotfiles` repository to the local repository `~/GitHub/dotfiles` and run `symlinks.sh` to construct symbolic links from the home directory dot files to the local repository.

## Specific macOS Preferences

```bash
# Show the ~/Library folder
chflags nohidden ~/Library

# Store screenshots in Dropbox
defaults write com.apple.screencapture location ~/Dropbox/Screenshots

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Show the full path at the top of the finder window
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES; killall Finder

# Immediate showing of hidden Dock
defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock

# Mail: Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
```

# Specific Applications

## Alfred

Set up syncing to `~/Dropbox/Alfred\ Sync` and supply the license for Powerpack.

## MacTeX

After the MacTeX install, we need to install extra fonts and set up access to my sty files.

### Fonts

I need to add the [MathTime Professional 2 fonts](http://www.pctex.com/mtpro2.html). General instructions can be found [here](http://cims.nyu.edu/~fennell/mtpro2/). For my set up, the fonts are installed as follows.

Change directory 

`cd /Users/miller/Dropbox/Software/TeX/MathTime Pro Fonts/mtpro2-texlive`

and make the installer script user executable (if it isn't already)

`chmod +x ./mtpro2-texlive.sh`

Then run the script, including the path to the font files

`./mtpro2-texlive.sh -i /Users/miller/Dropbox/Software/TeX/MathTime Pro Fonts/mtp2fonts/mtp2fonts.zip.tpm`

### Style Files

My personal sty files are stored and synced on Dropbox. Create the symbolic link so TeX knows where to find them.

`ln -s ~/Dropbox/Library/texmf/tex/latex ~/Library/texmf/tex/latex`

## Sublime Text

### Package Control

Instructions on setting up Package Control with Sublime Text are found [here](https://packagecontrol.io/installation#st3). (Heeding their warning, I'm not reproducing the code but rather linking to theirs.)

###Sync Packages

I [sync packages with Dropbox](https://packagecontrol.io/docs/syncing). I just need to create a sym link to those with

```bash
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
rm -r User
ln -s ~/Dropbox/Sublime/User
```

Now any package additions or changes will be synced across all my machines. 







