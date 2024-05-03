{ ... }:
_: super: {
  wallpapers.live = {
    killua = super.fetchurl {
      url = "https://files.catbox.moe/ph1d5s.mp4";
      hash = "sha256-UTxQeJGtQpcRlrrwFdKHNvXUvEvBQtpULwk13Pf4ihE=";
    };
    gojo = super.fetchurl {
      url = "https://files.catbox.moe/pun2yh.mp4";
      hash = "sha256-jFGJKyicmf+RnFCgQoUQkCxfo5ln2H9Rpt6vQEUeYfo=";
    };
  };
}
