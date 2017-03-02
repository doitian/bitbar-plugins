#!/usr/bin/env bash
script_name="$(basename "${BASH_SOURCE[0]}")"
host="${script_name%%:*}"
minmem="${script_name#*:}"
minmem="${minmem%%.*}"

curmem=$(ssh "$host" free | grep '^Mem: ' | awk '{print(int(($4+$7)/1024))}')
if (( curmem > 1024 )); then
  curmem_label="$(( curmem / 1024 ))G"
else
  curmem_label="$(( curmem ))M"
fi
if (( curmem > minmem )); then
  echo "${curmem_label} | color=green"
else
  echo "${curmem_label} | color=red"
fi
echo "----"
echo $host
