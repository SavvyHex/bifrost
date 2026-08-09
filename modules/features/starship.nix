{ inputs, ... }: {
  flake.nixosModules.starship = { pkgs, lib, ... }: {
    # Register zsh as a valid login shell and make it the account's default.
    # home-manager alone cannot change the account's login shell.
    programs.zsh.enable = true;
    users.users.savvyhex.shell = pkgs.zsh;

    home-manager.users.savvyhex = { pkgs, lib, config, ... }: {
      home.packages = [ pkgs.starship ];

      programs.zsh = {
        enable = true;
        initContent = ''
          eval "$(starship init zsh)"
        '';
      };

      # Kept enabled too, since non-interactive scripts / spawn-sh calls
      # in niri still invoke bash, not your interactive login shell.
      programs.bash.enable = true;

      # Seed starship.toml as a plain, writable file (NOT a home-manager
      # symlink) so iNiR's `applycolor.sh` can append its Material You
      # palette block into it on every wallpaper change. Only copies it
      # in if the file doesn't already exist, so reruns/rebuilds never
      # clobber colors iNiR has already written.
      home.activation.seedStarshipConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        target="$HOME/.config/starship.toml"
        if [ ! -e "$target" ]; then
          $DRY_RUN_CMD mkdir -p "$HOME/.config"
          $DRY_RUN_CMD cp ${./starship-default.toml} "$target"
          $DRY_RUN_CMD chmod u+w "$target"
        fi
      '';
    };
  };
}
