{ lib, pkgs, ... }:

let buildTmuxPlugin = pkgs.tmuxPlugins.mkTmuxPlugin;
in {
  monokai-pro = buildTmuxPlugin {
    pluginName = "monokai-pro";
    version = "v1.0";
    src = pkgs.fetchFromGitHub {
      owner = "loctvl842";
      repo = "monokai-pro.tmux";
      rev = "c1176717ecce54900d35d1ee9dddb2a5f4474323";
      sha256 = "sha256-3e8jqeg35T88l+QDJp1CZRroUweKNbc5Se1lExPd4z8=";
    };
  };
}
