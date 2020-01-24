# vim-cpp
A script for configuring your vim as IDE for c++

## Requirements
* Ubuntu
* python3

## How install the scripts
Once you clone the repository, execute the following steps:
* cd /path/to/vim-cpp
* chmod +x install_cpp_configuration.sh
* ./install_cpp_configuration.sh

## In your project
Once you successfully installed the script, go into your *CMake* project and generate the compile command file:
* cd /path/to/your/project
* mkdir build
* cd build
* cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
* mv compile_commands.json ../

Do not forget to do above procedure each time you add new libraries to your CMakeLists.txt.

## Launch vim
Go to main folder of your project and launch vim:
* ```vim .```;
* press Ctrl+l for generating the ctags;
* press F8 for reloading the .vimrc file.

Now your vim environment works perfectly with auto-complete activated.

## Help
If you need help with the main vim shortcuts, you can press F12 and a list of the main shorcuts I made
will appear into your vim terminal.

Please if you have any improvement, write me an email: andrea[dot]pennisi[at]gmail[dot]com.
