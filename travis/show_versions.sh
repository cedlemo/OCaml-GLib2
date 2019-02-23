#!/bin/bash

. /home/ocaml-glib2/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
echo "########################################################################"
echo "########################### LIBS VERSIONS ##############################"
echo
echo $(opam list --short --columns=package installed ocaml)
echo $(opam list --short --columns=package installed ctypes)
echo $(opam list --short --columns=package installed ctypes-foreign)
echo $(opam list --short --columns=package installed memcpy)
echo $(opam list --short --columns=package installed ounit)
echo $(opam list --short --columns=package installed base)
echo $(opam list --short --columns=package installed stdio)
echo $(opam list --short --columns=package installed configurator)
echo "GLib version: $(pkg-config --modversion glib-2.0)"
echo "GObject-Introspection version: $(pkg-config --modversion gobject-introspection-1.0)"
echo
echo "########################################################################"
echo "########################################################################"

