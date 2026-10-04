#set document(title: "How to add your talk", author: "Yernar Tursynali")
#set page(paper: "presentation-16-9", margin: 2cm)
#set text(size: 26pt)
#show heading: set text(size: 36pt)
#show raw.where(block: true): set text(size: 20pt)

#let slide(body) = { pagebreak(weak: true); body }

#align(center + horizon)[
  #text(size: 44pt)[*How to add your talk*] \
  Yernar Tursynali \
  #link("https://github.com/merura")[github.com/merura] \
  NixOS.kz Conference, November 2026
]

#slide[
  = 1. Make a directory

  ```
  <github-handle>-<title>/
  └── slides.typ
  ```

  Sources only. Images and code go next to `slides.typ`.
  Not Typst? Add `default.nix` that builds a PDF.
]

#slide[
  = 2. Build

  ```sh
  make <github-handle>-<title>
  ```

  Nix builds the PDF reproducibly. No PDFs in git.
]

#slide[
  = 3. Open a pull request

  CI builds every talk.
]

#slide[
  = 4. Done

  After merge, your slides appear on \
  #link("https://nixos-kz.github.io/nixos-kz-conf-2026-11/")
]
