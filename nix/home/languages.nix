{ pkgs, ... }:

{
  home.packages = with pkgs; [
    deno
    nodejs_22
    uv
    rustup
  ];
}
