{ config, system, pkgs, lib, ... }:

with lib;

{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/amazon-image.nix>
    /etc/nixos/ec2-data-user.nix
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

  systemd.services.test1 = {
        description = "test";
        wantedBy = [ "multi-user.target" ];
#       wantedBy = [ "" ];
        path = [ pkgs.git pkgs.nix ];

#       after = [ "fetch-ec2-metdata.service" ];

        script = ''echo "Start hook creation"
mkdir -m 1777 -p "/home/ec2-user/deploydir-final"
git init --bare "/home/ec2-user/bare-project.git"
chmod -R 1777 home/ec2-user/bare-project.git; chmod -R 1777 home/ec2-user/deploydir-final; tee /home/ec2-user/bare-project.git/hooks/post-receive <<EOF
#!/run/current-system/sw/bin/bash

TARGET="/home/ec2-user/deploydir-final"
GIT_DIR="/home/ec2-user/bare-project.git"
BRANCH="master"

while read oldrev newrev ref
do
if [ "\$ref" = "refs/heads/master" ];
then
echo "received"
git --work-tree="/home/ec2-user/deploydir-final" --git-dir="/home/ec2-user/bare-project.git" checkout -f master
else
echo "need master branch"
fi
done

EOF
chmod a+x /home/ec2-user/bare-project.git/hooks/post-receive; sed -i 's/\r//g' /home/ec2-user/bare-project.git/hooks/post-receive'';
#       serviceConfig = {
#               Type = "oneshot";
#               ExecStart = "${pkgs.echo}/bin/echo echo \"Hello World\" ";

#       };
#       serviceConfig.Type = "oneshot"
#       serviceConfig.RemainAfterExit = true;
#       serviceConfig.PassEnvironment = "DISPLAY";
  };


  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

  system.stateVersion = "23.05";

  services.nginx = {
    enable = true;
    recommendedOptimisation = true;
    virtualHosts."exemplu" = {
      listen = [ 
        {
          addr = "0.0.0.0";
          port = 80;
          ssl = false;
        }
      ];
      rejectSSL = true;
      http3 = false;
      root = "/var/www/exemplu/html";
      default = true;
    };
  };

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
  networking.firewall.allowedTCPPorts = [ 22 80 ];

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
        wget vim
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
}
