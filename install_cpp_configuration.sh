#!/bin/bash
current_dir="$PWD"
pyv="$(python3 -V 2>&1 | cut -d\  -f 2)"
pyv="${pyv::3}" 

sudo apt-get install -y python"$pyv"-dev
cd
echo "Installing Vim && Dependencies..."
sudo add-apt-repository ppa:jonathonf/vim && sudo update
sudo apt-get install -y vim git clang-8 libclang1-8 libclang-dev curl cmake exuberant-ctags python"$pyv"-dev
echo "..vim installed"

echo "Install Plugins.."
cd ~/.vim
mkdir bundle
cd bundle
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
git clone https://github.com/ycm-core/YouCompleteMe
cd YouCompleteMe
git remote add pm https://github.com/puremourning/YouCompleteMe
git fetch pm
git checkout signature-help
git submodule sync --recursive
git submodule update --init --recursive
./install.py --clangd-completer
#git submodule update --init --recursive
#python3 install.py --clang-completer

cd ~/.vim
mkdir autoload
cd autoload
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
##Copy the .vimrc file
cp "$current_dir"/script/.vimrc ~/
vim +'PlugInstall --sync' +qa
echo "..Plugins Installed"

echo "Copy Configuration Files.."
cd "$current_dir"
sed -i 's/"colorscheme dracula/colorscheme dracula/g' ~/.vimrc
cp script/help_commands.txt ~/.vim/
cp script/.ycm_extra_conf.py ~/.vim/
#cp script/cpp.snippets ~/.vim/plugged/vim-snippets/UltiSnips/
echo "..Files Copied"


