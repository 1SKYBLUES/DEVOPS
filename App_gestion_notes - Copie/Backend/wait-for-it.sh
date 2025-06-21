#!/usr/bin/env bash

hostport=$1
shift

# Gérer les options jusqu'à --
while [[ "$1" != "--" ]]; do
  shift
done

# Enlever le "--"
shift

cmd="$@"

# Séparation host et port
host=$(echo $hostport | cut -d':' -f1)
port=$(echo $hostport | cut -d':' -f2)

until nc -z "$host" "$port"; do
  echo "⏳ En attente de $host:$port..."
  sleep 1
done

echo "✅ $host:$port est prêt, lancement de l'application"
exec $cmd
