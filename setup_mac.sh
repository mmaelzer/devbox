# Install brew
command -v brew > /dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install cask
brew install caskroom/cask/brew-cask 2> /dev/null

# Install oh-my-zsh
if [ ! -f ~/.zshrc ]; then
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

# Install node.js
brew install node 2> /dev/null

# Install pure zsh theme
if [ ! -d /usr/local/lib/node_modules/pure-prompt ]; then
  npm install pure-prompt --global
fi

# Install updated vim
brew install vim 2> /dev/null

# Install the silver search
brew install the_silver_searcher 2> /dev/null

# Install fuzzy finder
brew install fzf 2> /dev/null

# Install golang
brew install go 2> /dev/null

# Install gitx
brew cask install gitx 2> /dev/null

# Install mysql
brew install mysql 2> /dev/null

# Start mysql
mysql.server start

# Install Sequel Pro
brew cask install sequel-pro

# Install redis
brew install redis 2> /dev/null
