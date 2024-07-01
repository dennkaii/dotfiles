let
  users = {
    dennkaii = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG7KdCN6mzw6v7Of8nfnSSdCgiafacKlcyvD2SCK2dyD";
  };
  machines = {
    aethyr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDlId19c0snWcYxZelflmpgOtYpTRQUHkS72Y1fiBnz+";
  };
  main = [users.dennkaii machines.aethyr];
in {
  "searx.age".publicKeys = main;
}
