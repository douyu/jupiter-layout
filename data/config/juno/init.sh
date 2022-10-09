#/bin/sh

echo "init juno-admin..."
/usr/local/bin/juno-admin --config=/root/juno/config/install.toml --install=true
/usr/local/bin/juno-admin --config=/root/juno/config/install.toml --mock=true

