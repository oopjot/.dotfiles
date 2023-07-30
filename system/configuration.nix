{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.extraOptions = ''
    extra-experimental-features = nix-command flakes
  '';

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "pl";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  services.xserver = {
		enable = true;
		desktopManager = {
			xterm.enable = false;
		};
		displayManager = {
			defaultSession = "none+i3";
		};
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				dmenu
				i3lock
				i3blocks
				i3status
			];
		};
	};


  

  # Configure keymap in X11
  services.xserver.layout = "pl";
  services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.piter = {
    isNormalUser = true;
		initialPassword = "pass";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    tree
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  networking = {
		hostName = "colorovo";
		defaultGateway = "192.168.0.1";
		nameservers = [ "8.8.8.8" ];
		interfaces.wlp3s0.ipv4.addresses = [ {
			address = "192.168.0.219";
			prefixLength = 24;
		} ];
		enableIPv6 = false;
		firewall.enable = true;
		networkmanager.enable = true;
  };
 

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

