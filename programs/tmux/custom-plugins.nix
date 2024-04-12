{ lib, pkgs, ... }:

let buildTmuxPlugin = pkgs.tmuxPlugins.mkTmuxPlugin;
in {
  gruvbox-tmux = buildTmuxPlugin {
    pluginName = "gruvbox-tmux";
    version = "v1.0";
    src = pkgs.fetchFromGitHub {
      owner = "thoreinstein";
      repo = "gruvbox-tmux";
      rev = "e3e6e95c3ed267a37f469a1308fed5c96aba1614";
      sha256 = "sha256-gi2yjb8iEQUFXvISPRJXKViJH8q4YqrfdwwaBnb7L20=";
    };
  };
}
