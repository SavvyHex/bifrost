{ self, ... }: {
  flake.nixosModules.docker = { pkgs, ... }: {
    imports = [
      self.nixosModules.omniroute
    ];

    virtualisation.docker.enable = true;
    virtualisation.oci-containers.backend = "docker";
  };
}