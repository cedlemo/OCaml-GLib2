#. /home/opam/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
dune build generator/gen.exe
dune exec generator/gen.exe
dune runtest --profile=release
