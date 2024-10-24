{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim
	  pkgs.neovim
	  pkgs.rustup
	  pkgs.vimPlugins.packer-nvim
	  pkgs.ripgrep
	  pkgs.fd
	  pkgs.nodejs_22
	  pkgs.marksman
	  pkgs.bat
	  pkgs.tmux
	  pkgs.oh-my-zsh
	  pkgs.cmatrix
	  pkgs.python3
        ];

      system.defaults = {
	dock.autohide = true;
	dock.mru-spaces = false;
	finder.AppleShowAllExtensions = true;
  	finder.FXPreferredViewStyle = "clmv";
  	loginwindow.LoginwindowText = "Hi, Richard!";
  	screencapture.location = "~/Pictures/screenshots";
  	screensaver.askForPasswordDelay = 10;
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.nix-path = "nixpkgs=flake:nixpkgs";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # finger print unlocks sudo
      security.pam.enableSudoTouchIdAuth = true;

      # Allow compiling of intel binaries through rosetta 
      nix.extraOptions = ''
       extra-platforms = x86_64-darwin aarch64-darwin
      '';

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."RIchard-Bownes" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
