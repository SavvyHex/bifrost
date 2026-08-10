{ ... }: {
  flake.nixosModules.nixLd = { pkgs, ... }: {
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib   # libstdc++.so.6
      zlib
      openssl
    ];
  };
}
