#!/bin/sh
set -euo pipefail

waitfor() {
    while ! nc -z $1 $2; do
        echo "Waiting for $1..."
        sleep 1
    done
}

if [ $# -eq 0 ]; then
    # Wait for Postgres and Redis
    waitfor postgres 5432
    waitfor redis 6379

    python3 manage.py collectstatic --noinput
    python3 manage.py makemigrations --noinput
    python3 manage.py migrate --noinput
    python3 manage.py shell <<EOF
from django.contrib.auth.models import User
try:
  admin = User.objects.get(username='$ADMIN_USER')
except User.DoesNotExist:
  User.objects.create_superuser('$ADMIN_USER', '$ADMIN_EMAIL', '$ADMIN_PASS')
EOF

    NODE_PATH=/node_modules node /server.js &
    set -- uwsgi --ini /etc/uwsgi.ini
fi

exec "$@"
