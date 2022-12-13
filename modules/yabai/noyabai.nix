{ ... }: {
  system.defaults = {
    dock = {
      autohide = false;
      showhidden = true;
      mru-spaces = true;
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = true;
      AppleFontSmoothing = 2;
      _HIHideMenuBar = false;
      KeyRepeat = 1;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.swipescrolldirection" = false;
    };
  };
}
