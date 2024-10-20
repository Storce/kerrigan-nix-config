{ config, pkgs, lib, ... }: 


{ 
  # Enable nginx and adjust firewall rules.
  services.nginx.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 25565 ];
  networking.firewall.allowedUDPPorts = [ 25565 ];
 
  # Set a few recommended defaults.
  #services.nginx = {
  #  recommendedGzipSettings = true;
  #  recommendedOptimisation = true;
  #  recommendedProxySettings = true;
  #  recommendedTlsSettings = true;
  #};
 
  # Add some hosting/Drupal specific packages.
  environment.systemPackages = with pkgs; [
    nodejs
    yarn
  ];
  
  # nginx server
  services.nginx.virtualHosts."joewang.me" = {
    addSSL = true;
    enableACME = true;
    root = "/var/website";
    #extraConfig = ''
    #  index index.html
    #'';
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "joewangzz1028@gmail.com";
  };
 
 
  # /var/lib/acme/.challenges must be writable by the ACME user
  # and readable by the Nginx user. The easiest way to achieve
  # this is to add the Nginx user to the ACME group.
  #users.users.nginx.extraGroups = [ "acme" ];
 
  # Optionally add some environment variables.
  # environment.variables = {
    # PLATFORM = "production";
}
