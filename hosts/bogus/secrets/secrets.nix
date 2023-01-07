# FIXME this key doesn't exist on the bogus host
let key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF2OppVtnZ63ykzlf5fPZxNJ9qGQ3RfC1tjZ4LLcEn37 trazyn@larkov.de";
in
{
  "fred.age".publicKeys = [ key ];
}
