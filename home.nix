{ pkgs, lib, inputs, ... }:
let
  username = "eastxuelian";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  confDir = "${homeDirectory}/config";
  nixConfDir = "/etc/nixos";
  fetchFromGitHub = pkgs.fetchFromGitHub;

  my-python-packages = ps:
    with ps; [
      requests
      datetime

      # pwn
      psutil
      click
      ropgadget
      rpyc
      ipython
      regex
      tqdm
      pycrypto

      # protobuf
      protobuf
      pyqt5
      pyqtwebengine
      websocket-client
      grpcio
      grpcio-tools

      matplotlib

      pandas

      (
        # ropper
        buildPythonPackage rec {
          pname = "ropper";
          version = "1.13.8";
          src = fetchPypi {
            inherit pname version;
            sha256 = "sha256-s4f2MCi+xnQ5l73OgXD25GXVjLoXbQaABqPZFe7M8Jg=";
          };

          doCheck = false;
          propagatedBuildInputs = [
            pkgs.python3Packages.capstone
            pkgs.python3Packages.filebytes
            pkgs.python3Packages.keystone-engine
          ];
        })

      (
        # pwncli
        buildPythonPackage rec {
          pname = "pwncli";
          version = "1.6";

          src = fetchFromGitHub {
            owner = "RoderickChan";
            repo = pname;
            rev = "4594d01f7ac983a06b4407735a068b1582ea59c5";
            sha256 = "sha256-ofq9KiGCgHrIFulfCid9h/4e55cPkgBAGjxG2bTafps=";
          };

          doCheck = false;
          propagatedBuildInputs =
            [ pkgs.python3Packages.click pkgs.python3Packages.pwntools ];
        })

      (
        # vmlinux-to-elf
        buildPythonPackage rec {
          pname = "vmlinux-to-elf";
          version = "1.0";
          src = fetchFromGitHub {
            owner = "marin-m";
            repo = pname;
            rev = "fa5c9305ae1c4bbcd2debabb810e7613def690a7";
            sha256 = "sha256-/q4pZAam96OL6rMDGJcxBGD02Oo8rDpKoOcnydFUioo=";
          };
          doCheck = false;
          propagatedBuildInputs = [
            pkgs.python3Packages.lz4
            pkgs.python3Packages.zstandard
            pkgs.python3Packages.python-lzo
          ];
        })

      (
        # alphanumeric shellcode
        buildPythonPackage rec {
          pname = "ae64";
          version = "1.0.2";
          src = fetchFromGitHub {
            owner = "veritas501";
            repo = pname;
            rev = "04763f0058efff48c4f6a3bac162c4ec584ada7a";
            sha256 = "sha256-nwim9pLxp8Av0dXBZAhau2uLz2tKfp0VRj7U461E8NA=";
          };
          doCheck = false;
          propagatedBuildInputs = [
            pkgs.python3Packages.keystone-engine
            pkgs.python3Packages.z3-solver
          ];
        })

      (
        # lianpwn
        buildPythonPackage rec {
          pname = "lianpwn";
          version = "0.2.2";
          # src = ./packages/lianpwn;
          src = fetchPypi {
            inherit pname version;
            sha256 = "sha256-s4f2MCi+anQ5l73OgXD25GXVjLoXbQaABqPZFe7M8Jg=";
          };
          propagatedBuildInputs = [ ];
          doCheck = false;
        })
    ];

  defaultPkgs = with pkgs; [
    any-nix-shell # fish support for nix shell
    eza # a better `ls`
    fd # "find" for files
    gimp # gnu image manipulation program
    glow # terminal markdown viewer
    hyperfine # command-line benchmarking tool
    pre-commit

    neofetch
    nnn # terminal file manager
    starship
    git
    tmux

    zip
    xz
    unzip
    p7zip

    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    grc

    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    zoxide

    nix-output-monitor
    any-nix-shell

    just

    btop # replacement of htop/nmon
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    ethtool
    pciutils # lspci
    usbutils # lsusb
    proxychains
    dconf

    gnumake
    gcc
    libclang

    # pwn
    # binutils-unwrapped
    nasm
    gdb
    file
    patchelf
    one_gadget
    qemu
    pahole
    inputs.patch4pwn.defaultPackage.x86_64-linux
    inputs.pwndbg.packages.x86_64-linux.default

    neovim
    inputs.lianvim-banner.defaultPackage.x86_64-linux
    lazygit
    ruff
    asmfmt
    astyle
    black
    isort
    nixfmt-classic
    prettierd
    rustfmt
    stylua
    neocmakelsp

    docker-compose
    hexo-cli

    gitleaks

    protobuf
  ];
in {
  programs.home-manager.enable = true;

  imports = lib.concatMap import [ ./programs ];

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "23.11";

    packages = defaultPkgs
      ++ [ (pkgs.python3.withPackages my-python-packages) ];

    file = {

      ".gdbinit".text = ''
        source ${confDir}/pwn-scripts/nixos-conf/gdb_loadebug.py
        add-auto-load-safe-path /Users/eastxuelian/.gdbinit
        source ${inputs.pwndbg.packages.x86_64-linux.default}/share/pwndbg/gdbinit.py
      '';
      ".pwncli.conf".text = ''
        [context]
        log_level = debug
        timeout = 1145141919810

        [debug]
        load_gadget = True
        attact_mode = "tmux"

        [remote]
        ip = 127.0.0.1
        proxy_mode = primitive
        load_gadget = True

        [patchelf]
        libs_dir = ~/glibc-all-in-one/libs

        [proxy]
        type = socks5
        host = host.orb.internal
        port = 6153
        rdns = True
      '';
      ".config/patch4pwn/config".text = ''
        base_dir=/home/eastxuelian/config/glibc-all-in-one/libs
      '';
      ".local/state/nix/profile/bin/gh-md-toc".source =
        ./packages/gh-md-toc/gh-md-toc;
      ".local/state/nix/profile/bin/seccomp-tools".source =
        ./packages/seccomp-tools/seccomp-tools;
      ".config/neofetch/config.conf".source = ./programs/neofetch/config.conf;
    };

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
      XDG_DATA_HOME = "${homeDirectory}/.local/share";
      PYTHONPATH = "${nixConfDir}/packages/AwdPwnPatcher";
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
      LANGUAGE = "en_US.UTF-8";
      PYTHONIOENCODING = "UTF-8";
      # PACKAGES_PATH = "${nixConfDir}/packages";
      # PATH = "${homeDirectory}/.local/share/gem/ruby/3.1.0/bin";
      # BROWSER = "${lib.getExe pkgs.firefox-beta-bin}";
    };

    sessionPath = [ ];
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";
}
