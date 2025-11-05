ROOT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."
HOSTNAME="$(hostname | sed 's/\.local$//')"

HOST_FLAKE_DIR="$ROOT_DIR/hosts/$HOSTNAME"
