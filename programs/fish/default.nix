{ pkgs, lib, ... }:
let
  confDir = "/home/eastxuelian/config";
  nixConfDir = "/etc/nixos";
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      bind -M insert \ce accept-autosuggestion
      bind -M insert \cl 'clear; commandline -f repaint'

      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      _prompt_move_to_bottom
    '';

    shellAliases = {
      ls = "eza";
      tree = "eza -T";
      l = "eza";
      ll = "eza -al";
      la = "eza -al";
      objdump = "objdump -M intel";
      sudo = "sudo -E";
      shell_kernel = "nix-shell /etc/nixos/packages/libLian/exp.nix";
      shell_wget = "nix-shell ${confDir}/pwn-scripts/nixos-conf/wget_shell.nix";
      shell_fhs = "nix-shell ${confDir}/pwn-scripts/nixos-conf/gcc_shell.nix";
      clear = "clear && _prompt_move_to_bottom";
    };

    functions = {
      fish_greeting = "echo NixOS on hyper v - 12900k";
      _prompt_move_to_bottom = {
        onEvent = "fish_postexec";
        body = "tput cup $LINES";
      };
      dopwn = ''
        cp ${confDir}/pwn-scripts/nixos-conf/pwn_template-cli.py $argv
      '';
      dokernel = ''
        cp -r ${confDir}/pwn-scripts/kernel_template/c_template ./exploits
        cd ./exploits
        direnv allow
      '';
      # nix-shell ${nixConfDir}/packages/libLian/exp.nix

      set_proxy = ''
        set -gx all_proxy "socks5://192.168.50.30:6153"
        set -gx https_proxy "http://192.168.50.30:6152"
        set -gx http_proxy "http://192.168.50.30:6152"
      '';
      unset_proxy = ''
        set -e all_proxy
        set -e https_proxy
        set -e http_proxy
      '';
      txls = "tmux ls";
      txattach = ''
        if tmux has-session -t $argv 2>/dev/null
            echo "Session $argv exists. Attaching..."
            tmux attach -t $argv
        else
            echo "Session $argv does not exist. Creating..."
            tmux new -s $argv
        end
      '';
      cp = ''
        if test -d $argv[1]
            command cp -r $argv
        else
            command cp $argv
        end
      '';
    };

    shellInit = ''
      starship init fish | source
      function starship_transent_rmpt_func
          starship module time
      end
      enable_transience
    '';

    plugins = [
      # grc for colorized command output
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
      {
        name = "autopair.fish";
        src = pkgs.fishPlugins.autopair.src;
      }
      # { name = "fzf"; src = pkgs.fishPlugins.fzf.src; }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
  };
}

