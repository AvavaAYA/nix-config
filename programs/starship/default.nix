{ pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings = {
      format = lib.concatStrings [
        "$directory"
        "\${custom.git_server_icon}"
        "$git_branch"
        "$git_status"
        "\${custom.nix_shell}"
        "\${custom.direnv} "
        "$line_break"
        "$character"
      ];
      right_format = "$cmd_duration";
      directory = { style = "bold #78dce8"; };
      git_branch = {
        symbol = "";
        style = "bold #f74e27"; # git brand color
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };
      cmd_duration = {
        format = "[ $duration]($style)";
        style = "bold #586068";
      };
      directory = { read_only = " 󰌾"; };
      git_commit = { disabled = true; };
      git_state = { disabled = true; };
      git_metrics = { disabled = true; };
      custom = {
        git_server_icon = {
          description =
            "Show a GitLab or GitHub icon depending on current git remote";
          when = "git rev-parse --is-inside-work-tree 2> /dev/null";
          command = ''
            GIT_REMOTE=$(git ls-remote --get-url 2> /dev/null); if [[ "$GIT_REMOTE" =~ "github" ]]; then printf "\e[1;37m\e[0m"; elif [[ "$GIT_REMOTE" =~ "gitlab" ]]; then echo ""; else echo "󰊢"; fi'';
          shell = [ "bash" "--noprofile" "--norc" ];
          style = "bold #f74e27"; # git brand color
          format = "[$output]($style)  ";
        };
        nix_shell = {
          description = "Show an indicator when inside a Nix ephemeral shell";
          when = ''[ "$IN_NIX_SHELL" != "" ]'';
          shell = [ "bash" "--noprofile" "--norc" ];
          style = "bold #6ec2e8";
          format = "[ ]($style)";
        };
        direnv = {
          description = "Show '.envrc' when using a direnv environment";
          when = ''[ "$DIRENV_DIR" != "" ]'';
          shell = [ "bash" "--noprofile" "--norc" ];
          style = "italic #e5c07b";
          format = "[via](italic #586068) [.envrc]($style)";
        };
      };
    };
  };
}

