SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo $SCRIPT_DIR

rm -rf ~/.config/nvim
rm ~/.vimrc

# generate symbolic link nvim preference
mkdir -p ~/.config/nvim

`ln -fns ${SCRIPT_DIR}/init.vim ~/.config/nvim/init.vim`

# generate symbolic link vim/nvim plugin preference
`ln -fns ${SCRIPT_DIR}/dein.toml ~/.config/nvim/dein.toml`
`ln -fns ${SCRIPT_DIR}/dein_lazy.toml ~/.config/nvim/dein_lazy.toml`

# generate symbolic link vim preference
`ln -fns ${SCRIPT_DIR}/.vimrc ~/.vimrc`
