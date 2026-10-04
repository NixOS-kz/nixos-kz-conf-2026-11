{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      isTalk = name: type: type == "directory"
        && (builtins.pathExists ./${name}/slides.typ || builtins.pathExists ./${name}/default.nix);
      talks = builtins.attrNames (lib.filterAttrs isTalk (builtins.readDir ./.));

      talk = pkgs: name:
        if builtins.pathExists ./${name}/default.nix
        then pkgs.callPackage ./${name} { }
        else
          pkgs.runCommand "${name}.pdf" { nativeBuildInputs = [ pkgs.typst ]; } ''
            typst compile --ignore-system-fonts --root ${./${name}} ${./${name}}/slides.typ $out
          '';
      title = "NixOS.kz Conference, November 2026";
      index = names: ''
        <!doctype html>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>${title}</title>
        <style>body { font: 18px/1.6 system-ui; max-width: 40rem; margin: 3rem auto; padding: 0 1rem }</style>
        <h1>${title}</h1>
        <ul>
        ${lib.concatMapStrings (n: ''<li><a href="${n}.pdf">${n}</a>'' + "\n") names}</ul>
      '';
    in
    {
      packages = lib.genAttrs systems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          built = lib.genAttrs talks (talk pkgs);
        in
        built // {
          default = pkgs.runCommand "site" { } ''
            mkdir $out
            ${lib.concatMapStrings (n: "cp ${built.${n}} $out/${n}.pdf\n") talks}
            cp ${pkgs.writeText "index.html" (index talks)} $out/index.html
          '';
        });

      formatter = lib.genAttrs systems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
