# packages.nix
{ config, pkgs, ... }: with pkgs;

rec {

  package-set = builtins.concatLists [
   
    _cli
    _browser
    _dev
    _nix
];


  _nix = [

    # nix-shell into zsh 
    any-nix-shell
    nix-init
    nh
    # the below 2 are part of nh, but useful on their own too
    # nom - a drop-in replacement for nix command
    nix-output-monitor
    # nvd can be used to e.g. diff system generations i.e.:
    # nvd diff /nix/var/nix/profiles/system-{463,464}-link
    nvd 
    
];

  _browser = [
     
    firefox
];

  _cli = [
   
    btop 
    direnv
    curl
    wget
    eza
    unzip
    fzf
    bat
    fd
    neofetch
    zsh
    vim
];

  _dev = [

    lazygit
    git 
    vscode.fhs

];

}
