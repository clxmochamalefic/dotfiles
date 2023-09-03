#!/bin/bash

sudo apt install -y zliblg-dev

# git clone asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1

# install asdf to .bashrc
. "$HOME/.asdf/asdf.sh"

# install asdf completions
. "$HOME/.asdf/completions/asdf.bash"

# install asdf plugins

## install dependencies
apt-get install dirmngr gpg curl gawk

## add plugins
### asdf plugin manager
asdf plugin add asdf-plugin-manager https://github.com/asdf-community/asdf-plugin-manager.git
# Pin the asdf-plugin-manager version using git tag or even better using git hash which is immutable.
#asdf plugin update asdf-plugin-manager v1.0.0

### langs
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add php https://github.com/asdf-community/asdf-php.git
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git

asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin-add python

asdf plugin-add zig https://github.com/asdf-community/asdf-zig.git
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
asdf plugin-add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git

### runtime
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
asdf plugin-add flutter

### lxc
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git

### hashicorp
asdf plugin-add boundary https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add consul https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add levant https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add nomad https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add packer https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add sentinel https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add serf https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add terraform-ls https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add tfc-agent https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add vault https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add waypoint https://github.com/asdf-community/asdf-hashicorp.git

## install plugins
# Install specific version
asdf install asdf-plugin-manager latest

# Set a version globally (on your ~/.tool-versions file)
asdf global asdf-plugin-manager latest

# Now asdf-plugin-manager command is available
asdf-plugin-manager version


asdf plugin install nodejs        lasest
asdf plugin install php           latest
asdf plugin install golang        latest

asdf plugin install ruby          latest
asdf plugin install python        latest

asdf plugin install zig           latest
asdf plugin install rust          latest
asdf plugin install dotnet-core   latest

asdf plugin install deno          latest
asdf plugin install flutter       latest

asdf plugin install kubectl       latest

asdf plugin install boundary      latest
asdf plugin install consul        latest
asdf plugin install levant        latest
asdf plugin install nomad         latest
asdf plugin install packer        latest
asdf plugin install sentinel      latest
asdf plugin install serf          latest
asdf plugin install terraform     latest
asdf plugin install terraform-ls  latest
asdf plugin install tfc-agent     latest
asdf plugin install vault         latest
asdf plugin install waypoint      latest


asdf global nodejs        lasest
asdf global php           latest
asdf global golang        latest

asdf global ruby          latest
asdf global python        latest

asdf global zig           latest
asdf global rust          latest
asdf global dotnet-core   latest

asdf global deno          latest
asdf global flutter       latest

asdf global kubectl       latest

asdf global boundary      latest
asdf global consul        latest
asdf global levant        latest
asdf global nomad         latest
asdf global packer        latest
asdf global sentinel      latest
asdf global serf          latest
asdf global terraform     latest
asdf global terraform-ls  latest
asdf global tfc-agent     latest
asdf global vault         latest
asdf global waypoint      latest


echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc
