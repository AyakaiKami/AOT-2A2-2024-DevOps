# This module defines a systemd service that sets the SSH host key for denishritcu

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
    systemd.services.apply-denishritcu-data-user =
      { description = "Apply EC2 Data denishritcu";

        wantedBy = [ "multi-user.target" "sshd.service" ];
        before = [ "sshd.service" ];
        after = ["fetch-ec2-metadata.service"];

        path = [ pkgs.iproute2 ];

        script =
          ''
            if ! [ -e /home/denishritcu/.ssh/authorized_keys ]; then
                echo "obtaining SSH key..."
                mkdir -m 0700 -p /home/denishritcu/.ssh
                chown denishritcu:users /home/denishritcu/.ssh
                if [ -s /etc/ec2-metadata/public-keys-0-openssh-key ]; then
                    cat /etc/ec2-metadata/public-keys-0-openssh-key >> /home/denishritcu/.ssh/authorized_keys
                    echo "new key added to authorized_keys"
                    chmod 600 /home/denishritcu/.ssh/authorized_keys
                    chown denishritcu:users /home/denishritcu/.ssh/authorized_keys
                fi
            fi
          '';

        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = true;
      };

  };
}
