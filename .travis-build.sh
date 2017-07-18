sh .travis-libffi.sh
sh .travis-ocaml.sh
export OPAMYES=1
eval `opam config env`
opam install ocamlfind
opam install jbuilder
opam install ounit
opam install ctypes
opam install ctypes-foreign
opam install base
opam install stdio
opam install configurator
sh .travis-gobject-introspection.sh
jbuilder build # jbuilder runtest when tests will be started.
