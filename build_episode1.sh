#!/bin/bash

ASSETS="./assets"
OUTPUT="Episode1_Master_1080p40s.mp4"

D1=6
D2=6
D3=6
D4=6
D5=6
D6=6

ffmpeg -y -loop 1 -i $ASSETS/scene1.png -t $D1 -vf "scale=1080:1080" -c:v libx264 -pix_fmt yuv420p scene1.mp4
ffmpeg -y -loop 1 -i $ASSETS/scene2.png -t $D2 -vf "scale=1080:1080" -c:v libx264 -pix_fmt yuv420p scene2.mp4
ffmpeg -y -loop 1 -i $ASSETS/scene3.png -t $D3 -vf "scale=1080:1080" -c:v libx264 -pix_fmt yuv420p scene3.mp4
ffmpeg -y -loop 1 -i $ASSETS/scene4.png -t $D4 -vf "scale=1080:1080" -c:v libx264 -pix_fmt yuv420p scene4.mp4
ffmpeg -y -loop 1 -i $ASSETS/scene5.png -t $D5 -vf "scale=1080:1080" -c:v libx264 -pix_fmt yuv420p scene5.mp4
ffmpeg -y -loop 1 -i $ASSETS/scene6.png -t $D6 -vf "scale=1080:1080" -c:v libx264 -pix_fmt yuv420p scene6.mp4

printf "file 'scene1.mp4'\nfile 'scene2.mp4'\nfile 'scene3.mp4'\nfile 'scene4.mp4'\nfile 'scene5.mp4'\nfile 'scene6.mp4'\n" > scenes.txt

ffmpeg -y -f concat -safe 0 -i scenes.txt -c copy temp_video.mp4

ffmpeg -y -i temp_video.mp4 -i $ASSETS/vo.wav -i $ASSETS/music.wav \
-filter_complex "[1:a]volume=1.0[vo]; [2:a]volume=0.25[music]; [vo][music]amix=inputs=2:dropout_transition=2[aout]" \
-map 0:v -map "[aout]" -c:v libx264 -c:a aac -shortest $OUTPUT

rm scene1.mp4 scene2.mp4 scene3.mp4 scene4.mp4 scene5.mp4 scene6.mp4 temp_video.mp4 scenes.txt

echo "Built: $OUTPUT"
