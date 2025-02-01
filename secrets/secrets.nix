let
  hades = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIezBKQfXf4ZHTKyCBavmlIXVFhJ7xd4MltEubJe9Kxe";
  zagreus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQ8s7HeNm2rc4jxPdontGgXy3am1qSkXDbOgnT4Kz+J";
  nyx = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICbOHwz77EKBqxqIKCHAmjjzEn6kHGaFtBzQZQvFo+08";
in
{
  "secret.age".publicKeys = [ zagreus hades nyx ];
}
