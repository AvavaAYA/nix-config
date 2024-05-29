{ pkgs, lib, ... }: {
  home = {
    file.".ssh/config".text = ''
      Host github.com
          Hostname ssh.github.com
          Port 443
          User git
          ProxyCommand ${pkgs.netcat}/bin/nc -v -x host.orb.internal:6153 %h %p
      Host github.com
          port 22
          User git
          HostName github.com
          PreferredAuthentications publickey
          ProxyCommand ${pkgs.netcat}/bin/nc -v -x host.orb.internal:6153 %h %p

      Host compiling_20
          port 22
          User eastxuelian
          HostName 192.168.50.24
          PreferredAuthentications publickey
    '';
    # file.".ssh/authorized_keys".text = ''
    #   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEnuS1SQboj8j1A2zjlRnqB3b2IhfcJz+8hXRMKvAV+j eastxuelian@eastxuelian
    # '';
  };
}

