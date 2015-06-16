let

  saluton = import ./saluton/default.nix {};
  # Import the build expression for the Haskell code.

in

{
  network.description = "saluton";

  saluton =
    { config, pkgs, ... }:
    { networking.hostName = "saluton";

      networking.firewall.allowedTCPPorts = [ 22 80 ];
      # By default, nixos comes with a simple firewall configured to only
      # accept traffic on port 22 (ssh).

      environment.systemPackages = [ saluton ];
      # Include our Haskell code in the globally installed system packages.

      systemd.services.saluton =
        { description = "Saluton Webserver";
          wantedBy = [ "multi-user.target" ]; # Specify that the system wants this service to run.
          after = [ "network.target" ]; # Start the webserver after the network has come up.
          serviceConfig =
            { ExecStart = "${saluton}/bin/saluton"; # Give the absolute path of saluton to systemd.
            };
        };
    };
}
