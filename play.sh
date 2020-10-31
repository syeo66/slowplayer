#!/bin/bash

VIDEO=/home/pi/Videos/BigBucksBunny.mp4

MAXCOUNT=$(ffprobe -show_format $VIDEO 2>/dev/null | grep -F duration | cut -d= -f2 | xargs printf %.0f)
COUNT=$(cat /home/pi/position)

echo $COUNT/$MAXCOUNT

if [ $COUNT -lt $MAXCOUNT ]; then
	sudo IT8951/IT8951 0 0 0.bmp
	ffmpeg -ss $COUNT -y -i $VIDEO -vf "scale=h=600:w=800:force_original_aspect_ratio=increase,crop=w=800:h=600" -vframes 1 -s 800x600 1.bmp
	convert 1.bmp -colorspace gray -ordered-dither o8x8 0.bmp	
	let "COUNT+=1"
	echo $COUNT > /home/pi/position	
else
	echo 1 > /home/pi/position
fi
