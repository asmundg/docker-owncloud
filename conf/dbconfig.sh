#!/bin/sh -ex

for f in /usr/share/owncloud/config/autoconfig.php /usr/share/owncloud/config/config.php; do
    if [ -e $f ]; then
        sed -i "s/\"dbhost\"        => \"localhost\"/\"dbhost\"        => \"$DB_PORT_5432_TCP_ADDR\"/" $f
    fi
done
