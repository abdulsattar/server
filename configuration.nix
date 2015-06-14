{ config, pkgs, ...}:
{
  imports = [ ./amazon-base-config.nix ];
  ec2.hvm = true;

  users.extraUsers.bimorphic = {
    isNormalUser = true;
    home = "/home/bimorphic";
    description = "Abdulsattar Mohammed";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUWMpLWsqaHAvHdvAtTQjF3bMOpnreZP7vKztgWq2MUwNO6QEY4FsD7Uq8lAeDHzUF2xLfO5s2S5n/fUQJeECCWwCQS8HBRUVw+36qQhxFriWoxh7iEQ+NExesX13qX+jQGGebleU5A45fWVkWFfTBtu+8p764Vql8sG0tt08gzxBOcqTwB4h9BSC1AEYgP883OeHcdeCXvtmzTGqA+Kuy8HqT/KTDUtetDA44LH2hKMcJQ4OinibL01fi4Q3UyhEJDIE6j4BawZgiEoF1JAJuj3CT3120wWG3PxGgDf8MSUWbGiubiS0vpspGK1ezuJJydKAfnIclptM2koiSxkGl abdulsattar@abdulsattar-desktop" ];
  };

  services.openssh = {
    enable = true;
    permitRootLogin = pkgs.lib.mkForce "no";
    passwordAuthentication = false;
  };

  services.nginx = {
    enable = true;
    config = pkgs.lib.readFile /root/nginx.conf;
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql94;
  };
 
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowPing = true;
  networking.hostName = "bimorphic";

  nix.gc.automatic = true;
}
