{ pkgs, lib, ... }: {
  home = {
    file.".ssh/config".text = ''
      Host github.com
          Hostname ssh.github.com
          Port 443
          User git
          ProxyCommand ${pkgs.netcat}/bin/nc -v -x 192.168.50.30:6153 %h %p
      Host github.com
          port 22
          User git
          HostName github.com
          PreferredAuthentications publickey
          ProxyCommand ${pkgs.netcat}/bin/nc -v -x 192.168.50.30:6153 %h %p
    '';

  };
}

