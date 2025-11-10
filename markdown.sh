#!/bin/bash

echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "<meta http-equiv=\"Content-type\" content=\"text/html;charset=UTF-8\" />"
echo "</head>"
echo "<body>"

ZOZ="n"

while IFS= read LINE; do

  if echo "$LINE" | grep -q '^-[[:space:]]'; then
      
      if [ "$ZOZ" != "y" ]; then
          echo "<ul>"
          ZOZ="y"
      fi

      ITEM=$(echo "$LINE" | sed 's/^-[[:space:]]*//')
      echo "<li>$ITEM</li>"
      continue
  fi

  if [ "$ZOZ" = "y" ]; then
      echo "</ul>"
      ZOZ="n"
  fi

  if echo "$LINE" | grep -q '^[[:space:]]*$'; then
      echo "<p>"
      continue
  fi

  if echo "$LINE" | grep -q '^## '; then
      TEXT=$(echo "$LINE" | sed 's/^## //')
      echo "<h2>$TEXT</h2>"
      continue
  fi

  if echo "$LINE" | grep -q '^# '; then
      TEXT=$(echo "$LINE" | sed 's/^# //')
      echo "<h1>$TEXT</h1>"
      continue
  fi



  LINE=$(echo "$LINE" | sed 's@<https://\([^>]*\)>@<a href="https://\1">https://\1</a>@g')

  LINE=$(echo "$LINE" | sed 's@__\([^_][^_]*\)__@<strong>\1</strong>@g')

  LINE=$(echo "$LINE" | sed 's@_\([^_][^_]*\)_@<em>\1</em>@g')

  echo "$LINE"

done

if [ "$ZOZ" = "y" ]; then
    echo "</ul>"
fi

echo "</body>"
echo "</html>"


