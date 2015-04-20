#!/bin/bash
bundle_path="$HOME/.vim/bundle/"
tmp_path="$HOME/tmp/"

mkdir -p $bundle_path
mkdir -p $tmp_path

if [ "$1" == "all" ]; then
  # Copy over .vimrc
  curr_vimrc=$HOME/.vimrc
  bak_vimrc=$HOME/.vimrc_bak
  if [ -e $curr_vimrc ]; then
    echo "Backing up $curr_vimrc to $bak_vimrc"
    mv $curr_vimrc $bak_vimrc
  fi
  ln -s $(pwd)/.vimrc $HOME/.vimrc
fi

# Associative array of vim bundles
declare -A vim_bundles=(
  ["ag"]="/rking/ag.vim"
  ["nerdtree"]="/scrooloose/nerdtree.git"
  ["vim-javascript"]="/pangloss/vim-javascript.git"
  ["vim-go"]="/fatih/vim-go.git"
  ["ctrlp"]="/kien/ctrlp.vim.git"
  ["vim-gitgutter"]="/airblade/vim-gitgutter"
  ["vim-airline"]="/bling/vim-airline"
  ["vim-syntastic"]="/scrooloose/syntastic"
  ["vim-monokai"]="/crusoexia/vim-monokai"
  ["MatchTag"]="/gregsexton/MatchTag"
  ["vim-commentary"]="/tpope/vim-commentary"
)

# Install vim pathogen
if [ ! -e $HOME/.vim/autoload/pathogen.vim ]; then
  echo "Pathogen - installing"
  mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle 
  curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  echo "Pathogen - done"
fi

# Install silver searcher
if ! type ag > /dev/null; then 
  echo "Silver Searcher - installing w/ dependencies"
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    silver_searcher_linux
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    silver_searcher_mac
  fi
  echo "Silver Searcher - done"
fi

# Loop through list of vim bundles and copy them to ~/.vim/bundles if
# they don't already exist
for bundle in "${!vim_bundles[@]}"; do
  if [ ! -d "$bundle_path$bundle" ]; then
    echo "$bundle - installing"
    git clone https://github.com"${vim_bundles["$bundle"]}" "$bundle_path$bundle"
    echo "$bundle - done"
  else
    echo "$bundle - exists"
  fi
done

function silver_searcher_linux {
  sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
  tmp_ag_path=$tmp_path"ag"
  git clone https://github.com/ggreer/the_silver_searcher $tmp_ag_path
  (cd $tmp_ag_path && pwd && $(pwd)/build.sh && sudo make install)
  rm -rf $tmp_ag_path
}

function silver_searcher_mac {
  brew install the_silver_searcher
}
