{ pkgs, ... }: {
  imports = [ ./rust ./java ];

  environment.systemPackages = with pkgs; [ lldb so ];
}
