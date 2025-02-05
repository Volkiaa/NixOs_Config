{ config, pkgs, ... }:


{

programs.zsh ={
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nixrehome = "nixedit && home-manager switch --flake .#amsn";
      nixreflake = "nixedit && sudo nixos-rebuild switch --flake .#AmsNix";
      nixrebuild = "nixedit && sudo nixos-rebuild switch --flake .#AmsNix && home-manager switch --flake .#amsn";
      nixedit = "cd ~/.nixos-config/";
      ls = "eza --icons";
      ll = "eza --icons -l";
      ".." = "cd ..";
      "..." = "cd ../..";
      cat = "bat --paging=never";
      vim = "lvim";
    };
    oh-my-zsh   =  {
       enable  =  true;
       plugins = [
        "git"
        "history"
	"colored-man-pages"
          ];
        };
  };
  programs.oh-my-posh ={
	enable = true;
	enableZshIntegration = true;
	useTheme = "atomic"; 
  };


}
