{ lib, pkgs, ... }:
let
  # plugins = pkgs.tmuxPlugins // pkgs.callPackage ./custom-plugins.nix {};
  plugins = pkgs.tmuxPlugins;
  tmuxConf = lib.readFile ./default.conf;
in {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    # baseIndex = 0;
    extraConfig = tmuxConf;
    escapeTime = 0;
    keyMode = "vi";
    plugins = with plugins; [
      cpu
      # catppuccin # theme
      nord
      copycat
      # {
      #   plugin = resurrect;
      #   extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      # }
      # {
      #   plugin = continuum;
      #   extraConfig = ''
      #     set -g @continuum-restore 'on'
      #     set -g @continuum-save-interval '60' # minutes
      #   '';
      # }
    ];
    # shortcut = "a";
    terminal = "screen-256color";
  };
}

