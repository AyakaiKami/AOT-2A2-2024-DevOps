# This module defines a systemd service that sets the SSH host key for mateigalu

{ config, lib, pkgs, ... }:

with lib;

{
  #imports = [
  #  (mkRemovedOptionModule [ "ec2" "metadata" ] "")
  #];

  config = {
    programs.git = {
      enable = true;
    };
    systemd.services.apply-mateigalu-data-user =
      { description = "Apply EC2 Data mateigalu";

        wantedBy = [ "multi-user.target" "sshd.service" ];
        before = [ "sshd.service" ];
        after = ["fetch-ec2-metadata.service"];

        path = [ pkgs.iproute2 ];

        script =
          ''
            if ! [ -e /home/mateigalu/.ssh/authorized_keys ]; then
                echo "obtaining SSH key..."
                mkdir -m 0700 -p /home/mateigalu/.ssh
                chown mateigalu:users /home/mateigalu/.ssh
                if [ -s /etc/ec2-metadata/public-keys-0-openssh-key ]; then
                    cat /etc/ec2-metadata/public-keys-0-openssh-key >> /home/mateigalu/.ssh/authorized_keys
                    echo "new key added to authorized_keys"
                    chmod 600 /home/mateigalu/.ssh/authorized_keys
                    chown mateigalu:users /home/mateigalu/.ssh/authorized_keys
                fi
            fi
          '';

        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = true;
      };

  };
}
