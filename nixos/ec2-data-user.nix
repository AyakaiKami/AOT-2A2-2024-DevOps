# This module defines a systemd service that sets the SSH host key for ec2-user

{ config, lib, pkgs, ... }:

with lib;

{
  #imports = [
  #  (mkRemovedOptionModule [ "ec2" "metadata" ] "")
  #];

  config = {

    systemd.services.apply-ec2-data-user =
      { description = "Apply EC2 Data ec2-user";

        wantedBy = [ "multi-user.target" "sshd.service" ];
        before = [ "sshd.service" ];
        after = ["fetch-ec2-metadata.service"];

        path = [ pkgs.iproute2 ];

        script =
          ''
            if ! [ -e /home/ec2-user/.ssh/authorized_keys ]; then
                echo "obtaining SSH key..."
                mkdir -m 0700 -p /home/ec2-user/.ssh
                chown ec2-user:users /home/ec2-user/.ssh
                if [ -s /etc/ec2-metadata/public-keys-0-openssh-key ]; then
                    cat /etc/ec2-metadata/public-keys-0-openssh-key >> /home/ec2-user/.ssh/authorized_keys
                    echo "new key added to authorized_keys"
                    chmod 600 /home/ec2-user/.ssh/authorized_keys
                    chown ec2-user:users /home/ec2-user/.ssh/authorized_keys
                fi
            fi
          '';

        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = true;
      };

  };
}
