# programs/zsh.nix

{config, pkgs, inputs,  ... }:
{
 programs = {
   
   # Configure ZSH with custom settings
   zsh = {
     enable = true;
     autosuggestions.enable = true;
     zsh-autoenv.enable = true;
     syntaxHighlighting.enable = true;
     ohMyZsh   =  {
       enable  =  true;
       theme   =  "robbyrussell";
       plugins = [
        "git"
        "history"
          ];
        };
    };
  };
}