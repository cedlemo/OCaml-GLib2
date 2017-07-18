set -e
set -u

echo "Install FFI libs"
sudo apt-get install -qq -y \
   libffi6 \
   libffi-dev
