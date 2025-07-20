{
  services = {
    aria2 = {
      enable = true;
      rpcSecretFile = "/etc/secrets/aria2_rpc_secret.txt";
    };
  };

  users.users.krish.extraGroups = [ "aria2" ];
}
