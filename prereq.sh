#!/usr/bin/env bash

# Takes care of the prerequisites for software installs. This should be run before any 
# app or utility installs.

# Make script executable: chmod u+x prereq.sh

# Update the OS.
echo "------------------------------"
echo "Updating OSX...  If this requires a restart, run the script again."
# Install all available updates
sudo softwareupdate -i -a --verbose
# Install only recommended available updates
#sudo softwareupdate -ir --verbose

# Install Xcode Command Line Tools.
echo "------------------------------"
echo "Installing Xcode Command Line Tools..."
xcode-select --install

# Install Homebrew if we don't already have it (which we shouldn't).
echo "------------------------------"
echo "Installing Homebrew..."
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# Make sure we’re using the latest Homebrew.
brew update
# Upgrade any already-installed formulae.
brew upgrade

# Install mas.
echo "------------------------------"
echo "Installing mas..."
brew install mas
echo "------------------------------"
echo "Done with prerequisite installs."
echo "Now sign in to the Mac App Store to wrap up: 'mas signin myemail@myemail.com'"
