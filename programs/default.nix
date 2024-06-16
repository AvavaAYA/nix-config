let
  more = { pkgs, ... }: {
    programs = {
      bat.enable = true;

      broot = {
        enable = true;
        enableFishIntegration = true;
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      fzf = {
        enable = true;
        enableFishIntegration = false; # broken
        defaultCommand = "fd --type file --follow"; # FZF_DEFAULT_COMMAND
        defaultOptions = [ "--height 20%" ]; # FZF_DEFAULT_OPTS
        fileWidgetCommand = "fd --type file --follow"; # FZF_CTRL_T_COMMAND
      };

      # gpg.enable = true;

      # htop = {
      #   enable = true;
      #   settings = {
      #     sort_direction = true;
      #     sort_key = "PERCENT_CPU";
      #   };
      # };

      jq.enable = true;

      ssh.enable = true;

      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [ ];
      };

      # programs with custom modules
      # megasync.enable = true;
      # spotify.enable = true;
    };
  };
in [
  ./fish
  ./starship
  ./git
  ./tmux
  ./ssh
  # ./neofetch
  # ./lunarvim
  more
]

