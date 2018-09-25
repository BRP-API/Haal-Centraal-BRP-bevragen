#!/bin/sh

set -e  # exit on error

# Wait for the database container
# See: https://docs.docker.com/compose/startup-order/
db_host=${DATABASE_HOST:-db}
db_user=${DATABASE_USER:-postgres}
db_password=${DATABASE_PASSWORD}

until PGPASSWORD=$db_password psql -h "$db_host" -U "$db_user" -c '\q'; do
  >&2 echo "Waiting for database connection..."
  sleep 1
done

>&2 echo "Database is up."

# Collect static files
>&2 echo "Collect static files"
python src/manage.py collectstatic --noinput

# Apply database migrations
>&2 echo "Apply database migrations"
python src/manage.py migrate

# Start server
>&2 echo "Starting server"
uwsgi --http :8000 --module bip.wsgi --static-map /static=/app/static --static-map /media=/app/media  --chdir=src
