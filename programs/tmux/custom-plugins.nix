{ lib, pkgs, ... }:

let buildTmuxPlugin = pkgs.tmuxPlugins.mkTmuxPlugin;
in {

  # gruvbox-tmux = buildTmuxPlugin {
  #   pluginName = "gruvbox-tmux";
  #   rtpFilePath = "gruvbox-tmux-tpm.tmux";
  #   version = "e3e6e95";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "thoreinstein";
  #     repo = "gruvbox-tmux";
  #     rev = "e3e6e95c3ed267a37f469a1308fed5c96aba1614";
  #     sha256 = "sha256-gi2yjb8iEQUFXvISPRJXKViJH8q4YqrfdwwaBnb7L20=";
  #   };
  # };

  # gruvbox = mkTmuxPlugin {
  #   pluginName = "gruvbox";
  #   rtpFilePath = "gruvbox-tpm.tmux";
  #   version = "unstable-2022-04-19";
  #   src = fetchFromGitHub {
  #     owner = "egel";
  #     repo = "tmux-gruvbox";
  #     rev = "3f9e38d7243179730b419b5bfafb4e22b0a969ad";
  #     sha256 = "1l0kq77rk3cbv0rvh7bmfn90vvqqmywn9jk6gbl9mg3qbynq5wcf";
  #   };
  # };

}
