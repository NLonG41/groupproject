#!/bin/sh
set -e

# Create data directory if it doesn't exist
mkdir -p /app/data

# Initialize demo-database.json if it doesn't exist
if [ ! -f /app/data/demo-database.json ]; then
  echo '{"users":[],"subjects":[],"classes":[],"enrollments":[],"rooms":[],"schedules":[],"semesters":[],"attendance":[],"scores":[],"studentActions":[],"notifications":[]}' > /app/data/demo-database.json
  echo "Initialized demo-database.json"
fi

# Execute the main command
exec "$@"

