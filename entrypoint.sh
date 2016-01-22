#!/bin/bash

env | grep -e '^pen_cmd.*' -e '.*_pen_cmd.*' | while read line; do
  name=$(echo "$line" | cut -d= -f1)
  args=$(echo "$line" | cut -d= -f2- | envsubst)

  mkdir -p "/etc/service/$name"
  cat << EOF > "/etc/service/$name/run"
#!/bin/sh
exec /usr/local/bin/pen -f $args
EOF
  chmod +x "/etc/service/$name/run"
done

exec /sbin/my_init
