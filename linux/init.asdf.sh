#!/bin/bash

# git clone asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1

. "$HOME/.asdf/asdf.sh"

. "$HOME/.asdf/completions/asdf.bash"

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


asdf install nodejs        latest
asdf install php           latest
asdf install golang        latest

asdf install ruby          latest
asdf install python        latest

asdf install zig           latest
asdf install rust          latest
asdf install dotnet-core   latest

asdf install deno          latest
asdf install flutter       latest

asdf install kubectl       latest

asdf install boundary      latest
asdf install consul        latest
asdf install levant        latest
asdf install nomad         latest
asdf install packer        latest
asdf install sentinel      latest
asdf install serf          latest
asdf install terraform     latest
asdf install terraform-ls  latest
asdf install tfc-agent     latest
asdf install vault         latest
asdf install waypoint      latest


asdf global nodejs        latest
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
