# mattermost-formula
[![Build Status](https://travis-ci.org/ssplatt/mattermost-formula.svg?branch=master)](https://travis-ci.org/ssplatt/mattermost-formula)

Install and configure mattermost

 - https://about.mattermost.com/

## Development
Install and setup brew:
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

```
brew install cask
brew cask install vagrant
```

```
cd <formula dir>
bundle install
```
or
```
sudo gem install test-kitchen
sudo gem install kitchen-vagrant
sudo gem install kitchen-salt
```

Run a converge on the default configuration:
```
kitchen converge default
```
