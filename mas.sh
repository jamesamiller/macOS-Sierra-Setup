#!/usr/bin/env bash

# Install Mac App Store apps.

# Make script executable: chmod u+x mas.sh.

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
brew upgrade --all

# Ulysses
mas install 623795237
# Markdown Pro
mas install 465965038
# OmniGraphSketcher
mas install 404651688
# Keynote
mas install 409183694
# Numbers
mas install 409203825
# Pages
mas install 409201541
# Geogebra 5
#mas install 845142834 # This did not work
# Xcode (install later and separately if needed)
#mas install 497799835

# Just to be sure...
mas upgrade
