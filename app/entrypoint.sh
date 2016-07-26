#!/bin/sh
set -euo pipefail

if [ $# -eq 0 ]; then
    python3 manage.py collectstatic --noinput
    python3 manage.py makemigrations --noinput
    python3 manage.py migrate --noinput
    python3 manage.py shell <<EOF
from django.contrib.auth.models import User
User.objects.create_superuser('$ADMIN_USER', '$ADMIN_EMAIL', '$ADMIN_PASS')
EOF

    NODE_PATH=/node_modules node /server.js &
    set -- uwsgi --ini /etc/uwsgi.ini
fi

exec "$@"
