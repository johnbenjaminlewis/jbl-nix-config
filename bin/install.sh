#!/usr/bin/env bash
set -e

ROOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )
source "$ROOT_DIR/bin/_shared.sh"

NIXIT_SOURCE="$ROOT_DIR/bin/nixit"
NIXIT_DEST="$HOME/bin/nixit"

mkdir -p "$(dirname $NIXIT_DEST)"

cat <<EOF > "$NIXIT_DEST"
#!/usr/bin/env bash
exec "$(pwd)/bin/nixit" "\$@"
EOF

chmod +x "$NIXIT_DEST"
