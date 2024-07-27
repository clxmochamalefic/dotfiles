# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  users.users.cocoalix = {
    isNormalUser  = true;
    home  = "/home/cocoalix";
    description  = "cocoalix";
    extraGroups  = [ "users" "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    #openssh.authorizedKeys.keys  = [ "ssh-dss AAAAB3Nza... alice@foobar" ];
  };
  
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  # タイムゾーン
  time.timeZone = "Asia/Tokyo";

  # ロケール等の設定
  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.utf8";
    LC_IDENTIFICATION = "ja_JP.utf8";
    LC_MEASUREMENT = "ja_JP.utf8";
    LC_MONETARY = "ja_JP.utf8";
    LC_NAME = "ja_JP.utf8";
    LC_NUMERIC = "ja_JP.utf8";
    LC_PAPER = "ja_JP.utf8";
    LC_TELEPHONE = "ja_JP.utf8";
    LC_TIME = "ja_JP.utf8";
  };
 
  # システム全体向けにインストールするパッケージ
  environment.systemPackages = with pkgs; [
    containerd
    #docker
    #docker-compose
    gnupg
    #make
    cmake
    python3
    nodejs
    nodePackages."npm"
    nodePackages."yarn"
    nodePackages."pnpm"
    nodePackages."typescript"
    zsh
    git
  ];

  # この説明めっちゃわかりやすくて吹いた
  # https://zenn.dev/asa1984/articles/nixos-is-the-best#flake%E5%8C%96
  programs = {
    git = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true; # $EDITOR=nvimに設定
      viAlias = true;
      vimAlias = true;
    };
    starship = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
    #containerd = {
    #  enable = true;
    #};
  };

  # Docker を有効化する
  #virtualisation.containerd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
