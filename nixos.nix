{
  inputs,
  pkgs,
  ...
}: {
  boot = {
    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;

    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services = {
    # Enable flatpak.
    flatpak.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;
    };

    # Enable the X11 windowing system.
    xserver = {
      enable = true;

      # Enable the Cinnamon Desktop Environment.
      displayManager.lightdm.enable = true;
      desktopManager.cinnamon.enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "fr";
        variant = "";
      };
    };
  };

  # Configure console keymap
  console.keyMap = "fr";

  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    groups.saturn.gid = 1000;
    users.saturn = {
      description = "Saturn";
      extraGroups = ["networkmanager" "wheel"];
      group = "saturn";
      isNormalUser = true;
      linger = true;
      shell = pkgs.zsh;
      uid = 1000;
      packages = with pkgs; [
        #  thunderbird
      ];
    };
  };

  programs = {
    dwl.enable = true;

    # Install firefox.
    firefox.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 10";
      };
    };
    zsh = {
      enable = true;
      shellAliases.nrs = "nh os switch -f /etc/nixos/system.nix";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix = {
    channel.enable = false;
    settings = {
      auto-allocate-uids = true;
      auto-optimise-store = true;
      use-cgroups = true;
      experimental-features = [
        "auto-allocate-uids"
        "cgroups"
        "flakes"
        "nix-command"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      use-xdg-base-directories = true;
    };

    # flakeless specifics
    registry.nixpkgs.to = {
      type = "path";
      path = "${inputs.nixpkgs}";
    };
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];
  # Packages stuff.
  environment.systemPackages = with pkgs; [
    kitty
    neovim
    git
    gnumake
    fastfetch
    foot
    wmenu
    starship
    cmake
    wayland
    st
    gh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
