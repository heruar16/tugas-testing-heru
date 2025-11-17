#!/bin/bash

# Start PHP built-in server
php -S 127.0.0.1:8000 -t public/ >/dev/null 2>&1 &

# Tunggu server hidup
sleep 3

echo "Testing index.php"
curl -I http://127.0.0.1:8000/index.php

echo "Testing login.php"
curl -I http://127.0.0.1:8000/login.php

echo "Testing register.php"
curl -I http://127.0.0.1:8000/register.php
