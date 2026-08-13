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
      imports = [
        inputs.inir.homeModules.inir
        inputs.nix4nvchad.homeManagerModules.default
      ];

      home.stateVersion = "25.05";

      programs.inir = {
        enable = true;
        service.compositor = "niri";
        configSymlink.enable = true;
      };

      programs.nvchad = {
        enable = true;
        hm-activation = true;
        backup = true;
      };
    };
  };
}