{inputs, ...}: {
  imports = [inputs.hjem.nixosModules.default];

  hjem = {
    clobberByDefault = true;
    users.saturn = {
      # systemd services or user programs or symlinks here
    };
  };
}
