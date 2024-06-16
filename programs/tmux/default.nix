{ lib, pkgs, ... }:
let
  plugins = pkgs.tmuxPlugins // pkgs.callPackage ./custom-plugins.nix { };
  tmuxConf = lib.readFile ./default.conf;
in {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 0;
    extraConfig = tmuxConf;
    escapeTime = 0;
    keyMode = "vi";

    plugins = with plugins; [
      cpu
      battery
      copycat

      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery false
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10
          set -g @dracula-cpu-usage-label "CPU"
          set -g @dracula-cpu-display-load true
        '';
      }

      # {
      #   plugin = gruvbox;
      #   extraConfig = ''
      #     set -g @tmux-gruvbox 'dark'
      #   '';
      # }

    ];

    terminal = "xterm-kitty";
  };
}

