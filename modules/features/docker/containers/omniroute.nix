{ ... }: {
  flake.nixosModules.omniroute = { ... }: {
    virtualisation.oci-containers.containers.omniroute = {
      image = "diegosouzapw/omniroute:latest";
      autoStart = true;

      ports = [
        "20128:20128" # dashboard
        "20129:20129" # API
        "20132:20132" # live websocket
      ];

      volumes = [
        "omniroute-data:/app/data"
      ];

      environment = {
        PORT = "20128";
      };
    };
  };
}