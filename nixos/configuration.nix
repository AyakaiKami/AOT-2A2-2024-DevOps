{ pkgs, lib, ... }:

# aici nu stiu daca e ok
#let
#	cloneGitRepo = ''
#		cd /home
#		if [ ! -d "AOT_A2" ]; then
#			git clone https://github.com/Daniszz/TW_PROIECT2024 AOT_A2
#		else
#			cd AOT_A2
#			git pull origin master
#		fi
#	'';
#in
# pana aici

{
  imports = [ 
    <nixpkgs/nixos/modules/virtualisation/amazon-image.nix> 
    /etc/nixos/ec2-data-user.nix
    /etc/nixos/mateigalu-data-user.nix
    /etc/nixos/mateiburlacu-data-user.nix
    /etc/nixos/denishritcu-data-user.nix
    # Enables X11 windowing system and RDP access
    # Don't forget to set a password to ec2-user in order to log in through RDP
    # /etc/nixos/xrdp.nix 
    ];
  ec2.hvm = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

	system.stateVersion = "23.05";
  services.nginx = {
    enable = true;
    virtualHost."localhost" = {
      root = "/var/www/project
      index = "index.html";
    }
  }

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = lib.mkForce "no";
    };
  };
  # Security settings
  security.sudo.wheelNeedsPassword = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;

  users.mutableUsers = true;

	users.users = {
		mateigalu = {
			isNormalUser = true;
			description = "Matei Galu";
			home = "/home/mateigalu";
			createHome = true;
			extraGroups = [ "networkmanager" "wheel" ];
			hashedPassword = null;
      packages = with pkgs; [
        wget vim
        firefox
        git
      ];
		};

		denishritcu = {
			isNormalUser = true;
			description = "Denis Hritcu";
			home = "/home/denishritcu";
			createHome = true;
			extraGroups = [ "networkmanager" "wheel" ];
			hashedPassword = null;
      packages = with pkgs; [
        wget wim
        firefox
        git
      ];
		};

		mateiburlacu = {
			isNormalUser = true;
			description = "Matei Burlacu";
			home = "/home/mateiburlacu";
			createHome = true;
			extraGroups = [ "networkmanager" "wheel" ];
			hashedPassword = null;
      packages = with pkgs; [
        wget vim
        firefox
        git
      ];
		};
	};
  users.users.ec2-user = {
    isNormalUser = true;
    createHome = true;
	hashedPassword = null;
    extraGroups = [ "networkmanager" "wheel"];
    packages = with pkgs; [
        wget vim
        firefox
        git
    ];
  };
	
  #nici aici
	#system.activationScripts.cloneGitRepo = {
	#	text = ''
	#		${cloneGitRepo}
	#	'';
	#};
}

