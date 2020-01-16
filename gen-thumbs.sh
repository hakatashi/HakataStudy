#!/usr/bin/env bash

mkdir -p thumbnails

for ((i=1; ; i++)); do
  id="$(printf "%03d" $i)"
  if [ ! -f "hkt$id.png" ]; then
    break
  fi

  if [ -f "hkt$id-edit.png" ]; then
    infile="hkt$id-edit.png"
  else
    infile="hkt$id.png"
  fi

  outfile="thumbnails/hkt$id.webp"

  printf "[![]($outfile)]($infile) "
  if [ $((i%4)) = 0 ]; then
    printf "\n"
  fi

  if [ "$outfile" -nt "$infile" ]; then
    continue
  fi

  convert "$infile" \
    -resize 160x120^ -gravity center -extent 160x120 \
    -gravity northwest \
    -fill '#0008' -draw 'rectangle 0,0,34,17' \
    -font Helvetica-Bold -pointsize 15 -fill white -annotate +5+3 "$id" \
    -quality 90 -define webp:lossless=false \
    "$outfile"
done

printf "\n"