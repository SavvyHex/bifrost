{ self, inputs, ... }: {
  flake.nixosConfigurations.thor = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      self.nixosModules.thorConfiguration
      self.nixosModules.thorHome
    ];
  };
}
