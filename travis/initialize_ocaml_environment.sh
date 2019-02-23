#!/bin/bash
wget https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh -O - | sudo sh -s /usr/local/bin
/usr/local/bin/opam init --comp 4.05.0
opam install ctypes configurator base stdio ctypes-foreign jbuilder dune odoc bisect_ppx ounit memcpy
. /home/ocaml-glib2/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
opam pin add --yes gobject-introspection https://github.com/cedlemo/OCaml-GObject-Introspection.git
opam pin add --yes gi-bindings-generator https://github.com/cedlemo/OCaml-GI-ctypes-bindings-generator.git

