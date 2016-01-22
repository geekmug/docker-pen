#!/bin/bash

# Remove all of the built-in services
rm -rf /etc/service/*

# Remove all of the built-in init scripts
rm -rf /etc/my_init.d/*

# Create a service for each pen_cmd.* or .*_pen_cmd.* environment variable
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

# Switch over to the init process
exec /sbin/my_init
