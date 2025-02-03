# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./programs/programs_config.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "AmsNix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Budgie Desktop environment.
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.budgie.enable = true;
  # Enable the Plasma6 Desktop environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";
 
  # Enable fonts
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
  	nerd-fonts.fira-code
	nerd-fonts.droid-sans-mono
  ];
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  #Enable Flakes and Nix commands
  nix.settings.experimental-features = ["nix-command" "flakes"];  
 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amsn = {
    isNormalUser = true;
    description = "Amsn";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
  programs.zsh.enable = true ;
  users.defaultUserShell = pkgs.zsh; 
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #Use lists in programs/programs.nix to import packages
  environment.systemPackages = with import ./programs/programs.nix {inherit pkgs config ; }; package-set;

  # Automatic Update
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automatic Cleanup
  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than +3";
  };
  nix.settings.auto-optimise-store = true; 

  #Power Management
  powerManagement.powertop.enable = true;                           # enable powertop auto tuning on startup.

  services.system76-scheduler.settings.cfsProfiles.enable = true;   # Better scheduling for CPU cycles - thanks System76!!!
  services.thermald.enable = true;                                  # Enable thermald, the temperature management daemon. (only necessary if on Intel CPUs)
  services.power-profiles-daemon.enable = false;                    # Disable GNOMEs power management
  services.tlp = {                                                  # Enable TLP (better than gnomes internal power manager)
    enable = true;
    settings = { # sudo tlp-stat or tlp-stat -s or sudo tlp-stat -p
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_SCALING_MIN_FREQ_ON_AC = 400000;  # 400 MHz
      CPU_SCALING_MAX_FREQ_ON_AC = 4200000; # 4,2 GHz
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 81;
    };
  };
  
  system.stateVersion = "24.11"; # Actual System Version

}
