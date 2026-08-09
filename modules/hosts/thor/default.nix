{ self, inputs, ... }: {
  flake.nixosConfigurations.thor = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.thorConfiguration
    ];
  };
}
