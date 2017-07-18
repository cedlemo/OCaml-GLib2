sudo apt-get update -qq
sh .travis-gobject-introspection.sh
sh .travis-libffi.sh
echo "yes" | sudo add-apt-repository ppa:avsm/ocaml42+opam12
sudo apt-get install -qq opam
opam init
opam update
opam switch -q $OCAML_VERSION
eval `opam config env`
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
jbuilder runtest
