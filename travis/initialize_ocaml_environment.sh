#!/bin/bash
sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)
/usr/local/bin/opam init --comp 4.05.0
opam install ctypes configurator base stdio ctypes-foreign jbuilder dune odoc bisect_ppx ounit memcpy
opam pin add --yes gobject-introspection https://github.com/cedlemo/OCaml-GObject-Introspection.git
opam pin add --yes gi-bindings-generator https://github.com/cedlemo/OCaml-GI-ctypes-bindings-generator.git

