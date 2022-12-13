{ pkgs, ... }: {
  imports = [ ../system ../home ../../programming ];

  environment.systemPackages = with pkgs; [
    # Work
    slack
    thunderbird
    brightnessctl
  ];
}
