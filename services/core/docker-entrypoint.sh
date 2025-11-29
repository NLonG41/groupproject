#!/bin/sh
set -e

echo "🚀 Starting Core Service..."

# Wait for PostgreSQL to be ready (using pg_isready with connection string)
echo "⏳ Waiting for PostgreSQL to be ready..."
RETRIES=30
until pg_isready -h postgres -U usth_user -d usth_academic 2>/dev/null || [ $RETRIES -eq 0 ]; do
  echo "   PostgreSQL is unavailable - sleeping... ($RETRIES retries left)"
  RETRIES=$((RETRIES-1))
  sleep 2
done

if [ $RETRIES -eq 0 ]; then
  echo "❌ PostgreSQL failed to start"
  exit 1
fi

echo "✅ PostgreSQL is ready!"

# Run Prisma migrations
echo "📦 Running database migrations..."
npx prisma migrate deploy || {
  echo "⚠️  Migration failed, but continuing..."
}

echo "✅ Database setup completed!"

# Start the application
echo "🚀 Starting application..."
exec "$@"

