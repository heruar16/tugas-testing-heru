#!/usr/bin/env bash
set -euo pipefail

BASE="http://127.0.0.1:8080"
RETRIES=12
SLEEP_SEC=1

echo "Waiting for server at $BASE ..."
for i in $(seq 1 $RETRIES); do
  if curl -sSf "$BASE/index.php" >/dev/null 2>&1; then
    echo "Server is up (attempt $i)."
    break
  fi
  echo "Attempt $i/$RETRIES: server not ready yet, waiting ${SLEEP_SEC}s..."
  sleep $SLEEP_SEC
  if [ $i -eq $RETRIES ]; then
    echo "Server did not start after $RETRIES attempts — failing."
    exit 1
  fi
done

echo "=== Smoke checks ==="

# Check index/login pages
for path in index.php login.php register.php; do
  URL="$BASE/$path"
  echo "Checking $URL ..."
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || true)
  echo "HTTP $STATUS"
  if [ "$STATUS" != "200" ]; then
    echo "ERROR: $URL returned status $STATUS"
    exit 1
  fi
done

# Optional: test register POST (if register accepts simple form)
echo "Testing register POST (if endpoint accepts POST)..."
HTTP=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
     -d "username=testuser&password=secret123" "$BASE/register.php" || true)
echo "register POST HTTP $HTTP (if 200 or 302 it's OK)"
if [[ "$HTTP" != "200" && "$HTTP" != "302" ]]; then
  echo "Warning: register POST returned $HTTP (may be expected if DB not set) — failing."
  exit 1
fi

echo "All smoke tests passed."
