#!/bin/bash
opam install ctypes configurator base stdio ctypes-foreign jbuilder dune odoc bisect_ppx ounit memcpy gobject-introspection
opam pin add --yes gi-bindings-generator https://github.com/cedlemo/OCaml-GI-ctypes-bindings-generator.git

