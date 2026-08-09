# modules/hosts/thor/home.nix
{ inputs, ... }: {
  flake.nixosModules.thorHome = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { inherit inputs; };

    home-manager.users.savvyhex = { pkgs, ... }: {
      home.stateVersion = "25.05";

      gtk = {
        enable = true;
        iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
        };
      };

      home.sessionVariables = {
        XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
      };
    };
  };
}
