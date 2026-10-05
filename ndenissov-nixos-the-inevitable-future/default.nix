{ pkgs ? import <nixpkgs> { } }:

pkgs.runCommand "slides.pdf" { } ''
  cp ${./slides.pdf} $out
''
