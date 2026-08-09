{ self, inputs, ... }: {
  flake.nixosModules.thorHome = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.kitty
      self.nixosModules.starship
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { inherit inputs; };

    home-manager.users.savvyhex = { config, ... }: {
      imports = [ inputs.inir.homeModules.inir ];

      home.stateVersion = "25.05";

      programs.inir = {
        enable = true;
        service.compositor = "niri";
      };
    };
  };
}
