{ ... }: {
  flake.nixosModules.ly = { ... }: {
    services.displayManager.ly.enable = true;
    services.displayManager.defaultSession = "niri";
  };
}
