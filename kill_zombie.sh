#!/bin/bash

# Find and kill zombie processes
zombie_pids=()

while read -r pid; do
  zombie_pids+=("$pid")
done < <(ps aux | awk '$8=="Z" {print $2}')

if [ ${#zombie_pids[@]} -eq 0 ]; then
  echo "No zombie processes found."
else
  echo "Zombie processes found. Killing them..."
  for pid in "${zombie_pids[@]}"; do
    # Kill the parent process (PPID) of the zombie
    ppid=$(ps -o ppid= -p "$pid")
    echo "Killing zombie process $pid (parent process $ppid)"
    kill -9 "$ppid"
  done
  echo "Zombie process cleanup complete."
fi
