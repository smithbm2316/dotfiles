#!/usr/bin/sh
cd ~/builds || exit

# global npm packages
npm i -g \
  @olrtg/emmet-language-server \
  @tailwindcss/language-server \
  bash-language-server \
  css-variables-language-server \
  eslint_d \
  fixjson \
  graphql-language-service-cli \
  pnpm \
  prettier \
  typescript \
  typescript-language-server \
  vscode-langservers-extracted \
  write-good \
  yarn

# install odin programming language and its LSP + formatter
mkdir -pv ~/builds
cd ~/builds || exit
git clone https://github.com/DanielGavin/ols.git
cd ols || exit
./build.sh
./odinfmt.sh
mkdir -pv ~/.local/bin
ln -s ~/builds/ols/ols ~/.local/bin/ols
ln -s ~/builds/ols/odinfmt ~/.local/bin/odinfmt

# make sure to configure yarn to use version 1.x.x, since I truly never use it,
# and if I do, it's guaranteed to be a legacy project that uses the original
# version of yarn. make sure to remove the auto-generated ~/package.json in the
# $HOME dir that it generates, i don't want a package.json there
# cd ~ || exit
# yarn set version classic
# rm ~/package.json

cd ~/builds || exit
# phpactor
# curl -Lo phpactor.phar https://github.com/phpactor/phpactor/releases/latest/download/phpactor.phar
# chmod +x phpactor.phar
# mv -iv phpactor.phar ~/.local/bin/phpactor

# sqls
# go install github.com/sql-server/sqls@latest

# gopls language server
# go install golang.org/x/tools/gopls@latest

# templ lsp
# go install github.com/a-h/templ/cmd/templ@latest

# python - lsp (pyright/python-lsp-server), formatter (blue, djlint), etc
# pip install \
#   blue \
#   djlint \
#   jedi \
#   python-lsp-server

# sumneko_lua language server is installed with Brewfile

# teal language server
# sudo luarocks install --dev teal-language-server

# proselint for linting prose/markdown
# sudo dnf install -y proselint
