#!/bin/bash
set -e

# Extract host and port from ALEMBIC_URL (psycopg2 connection string)
DB_HOST=$(echo $ALEMBIC_URL | sed -E 's|.+@([^:/]+):([0-9]+)/.+|\1|')
DB_PORT=$(echo $ALEMBIC_URL | sed -E 's|.+@([^:/]+):([0-9]+)/.+|\2|')

echo "🚀 Waiting for PostgreSQL at $DB_HOST:$DB_PORT (IPv4 only)..."
while ! nc -4 -z "$DB_HOST" "$DB_PORT"; do
  echo "⌛ Database not ready, retrying..."
  sleep 2
done

echo "✅ PostgreSQL is up. Running Alembic migrations..."
alembic upgrade head

echo "🎉 Starting FastAPI application..."
exec uvicorn app.main:app --host 0.0.0.0 --port 8000
