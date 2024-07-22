#!/bin/bash

VIDEO_PATH=/home/pi/Videos/

CURRENT=$(cat /home/pi/video)
VIDEO=$VIDEO_PATH$CURRENT
MAXCOUNT=$(ffprobe -show_format $VIDEO 2>/dev/null | grep -F duration | cut -d= -f2 | xargs printf %.0f)
COUNT=$(cat /home/pi/position)

echo "$CURRENT: $COUNT/$MAXCOUNT"

jpegoptim --all-progressive --strip-all 0.jpg
cp /home/pi/0.jpg /home/pi/image.jpg

./minio-upload.sh slowplayer image.jpg

if [ $COUNT -lt $MAXCOUNT ]; then
	sudo IT8951/IT8951 0 0 0.bmp
	ffmpeg -ss $COUNT -y -i $VIDEO -vf "scale=h=600:w=800:force_original_aspect_ratio=increase,crop=w=800:h=600" -vframes 1 -s 800x600 1.bmp
	convert 1.bmp -normalize -level 0%,100%,1.5 -colorspace gray -ordered-dither o8x8 0.bmp
	convert 1.bmp -normalize -level 0%,100%,1.5 -colorspace gray -strip -interlace Plane -gaussian-blur 0.05 -quality 80% 0.jpg
	let "COUNT+=1"
	echo $COUNT > /home/pi/position	
else
	echo 1 > /home/pi/position
	for f in $(ls $VIDEO_PATH && ls $VIDEO_PATH);
	do
		if [ "$FOUND" == "1" ]; then
			echo "Next video: $f"
			echo $f > /home/pi/video
			FOUND=0
			exit 0
		fi
		if [ "$CURRENT" == "$f" ]; then
			FOUND=1
		fi
	done;
fi
