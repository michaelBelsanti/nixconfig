{
  delib,
  ...
}:
delib.module {
  name = "programs.rio";
  options = delib.singleEnableOption false;
  home.ifEnabled = {
    programs.rio = {
      enable = true;
      settings = {
        window.decorations = "Disabled";
        fonts = {
          size = 18;
        };
        keyboard.use-kitty-keyboard-protocol = true;
      };
    };
  };
}
