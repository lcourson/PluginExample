#!/bin/bash

mkdir -p /tmp/.vm.snapshot > /dev/null

virsh list --all --name > /tmp/.vm.snapshot/names

OUTPUT0="/tmp/.vm.snapshot/temp0"

echo "<select id=\"vmlist\">" > $OUTPUT0

while IFS="" read -r p || [ -n "$p" ]
do
  echo "<option value=\"$p\" selected disabled>$p</option>" >> $OUTPUT0
done < /tmp/.vm.snapshot/names

echo "</select>" >> $OUTPUT0