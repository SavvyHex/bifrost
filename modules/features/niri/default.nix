{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      cliphist
      polkit_gnome
    ];
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      "config.kdl".content =
        let
          configDir = ./config.d;
          read = name: builtins.readFile (configDir + "/${name}");

          input = lib.replaceStrings
            [ ''layout "us"'' ]
            [ ''layout "us,ua"'' ]
            (read "10-input-and-cursor.kdl");

          layout = lib.replaceStrings
            [
              "gaps 25"
              "recent-windows {"
            ]
            [
              "gaps 5"
              ''
                recent-windows {
                    binds {
                        Alt+Tab { next-window; }
                        Alt+Shift+Tab { previous-window; }
                    }
              ''
            ]
            (read "20-layout-and-overview.kdl");

          binds = lib.removeSuffix
            ''

              recent-windows {
                  binds {
                      Alt+Tab { next-window; }
                      Alt+Shift+Tab { previous-window; }
                  }
              }
            ''
            (read "70-binds.kdl");

          startup = lib.replaceStrings
            [ ''spawn-at-startup "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1"'' ]
            [ ''spawn-at-startup "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"'' ]
            (read "50-startup.kdl");
        in
        lib.concatStringsSep "\n\n" [
          ''
            prefer-no-csd
            hotkey-overlay {
                skip-at-startup
            }
            debug {
                honor-xdg-activation-with-invalid-serial
            }
            screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

            xwayland-satellite {
                path "${lib.getExe pkgs.xwayland-satellite}"
            }
          ''
          input
          layout
          (read "30-window-rules.kdl")
          (read "40-environment.kdl")
          startup
          (read "60-animations.kdl")
          binds
          (read "80-layer-rules.kdl")
          (read "90-user-extra.kdl")
        ];
    };
  };
}
