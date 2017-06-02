#!/usr/bin/env bash

# Install macOS apps available with Homebrew.

# Make script executable: chmod u+x apps.sh.

# Ask for the administrator password upfront.
sudo -v

# Keep alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Double check for Homebrew, and install if we don't have it.
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

############### Homebrew ################

# Core Homebrew formulae

# Development tool formulae
brew install ruby
brew install node
brew install git
brew install git-flow

# Misc formulae
brew install pandoc
brew install transmission

############### Cask ################

# Install Cask
brew tap caskroom/cask
brew tap caskroom/versions

# Core casks
brew cask install --appdir="/Applications" alfred
brew cask install --appdir="~/Applications" iterm2
brew cask install --appdir="~/Applications" java
brew cask install --appdir="~/Applications" xquartz

# Development tool casks
brew cask install --appdir="/Applications" sublime-text
brew cask install --appdir="/Applications" atom
brew cask install --appdir="/Applications" virtualbox
#brew cask install --appdir="/Applications" vagrant
#brew cask install --appdir="/Applications" macdown
brew cask install --appdir="/Applications" github-desktop
brew cask install --appdir="/Applications" tower

# Misc casks
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" chromium
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" epic
brew cask install --appdir="/Applications" torbrowser
brew cask install --appdir="/Applications" skype
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" ricochet
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" evernote
brew cask install --appdir="/Applications" 1password
brew cask install --appdir="/Applications" cryptomator
brew cask install --appdir="/Applications" viscosity
brew cask install --appdir="/Applications" google-earth
brew cask install --appdir="/Applications" google-drive
brew cask install --appdir="/Applications" spotify
#brew cask install --appdir="/Applications" adobe-creative-cloud
brew cask install caffeine

# Remove outdated versions from the cellar.
brew cleanup
