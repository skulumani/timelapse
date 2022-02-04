#!/bin/sh
# Combine daily MP4s into a single monthly video and upload to youtube

curl -m 10 --retry 5 https://hc-ping.com/452ac808-5c44-47f0-94dc-aa9e8f5b8210/start

YESTERDAY=$(date -d "yesterday" +"%Y%m%d")
LAST_MONTH=$(date -d "last month" +"%Y%m")
THIS_MONTH=$(date -d "this month" +"%Y%m")

IMAGE_DIR="/media/shankar/data/timelapse/"

FRONT_FILES="${IMAGE_DIR}front.txt"
BACK_FILES="${IMAGE_DIR}back.txt"

FRONT_VIDEO="${IMAGE_DIR}/monthly/${LAST_MONTH}_FRONT.mp4"
BACK_VIDEO="${IMAGE_DIR}/monthly/${LAST_MONTH}_BACK.mp4"

for filename in "${IMAGE_DIR}${LAST_MONTH}"*_FRONT.mp4; do
    [ -e "$filename" ] || continue
    echo "file '${filename}'" >> ${FRONT_FILES}
done

for filename in "${IMAGE_DIR}${LAST_MONTH}"*_BACK.mp4; do
    [ -e "$filename" ] || continue
    echo "file '${filename}'" >> ${BACK_FILES}
done

# concat mp4s
ffmpeg -hide_banner -r 30 -f concat -safe 0 -i ${FRONT_FILES} -vcodec libx264 -crf 28 -preset veryslow -pix_fmt yuv420p ${FRONT_VIDEO}
ffmpeg -hide_banner -r 30 -f concat -safe 0 -i ${BACK_FILES} -vcodec libx264 -crf 28 -preset veryslow -pix_fmt yuv420p ${BACK_VIDEO}

# delete mp4s
find ${IMAGE_DIR} -maxdepth 1 -type f -name "${LAST_MONTH}*.mp4" -exec rm {} +

# Delete file list documents
rm ${FRONT_FILES}
rm ${BACK_FILES}

# Upload to youtube
# conda activate timelapse

# youtube-upload \
#     --title="${LAST_MONTH}_FRONT" \
#     --description="Timelapse video" \
#     --client-secrets="client_secrets.json" \
#     --playlist="Timelapse Front" \
#     --privacy="private" \
#     ${FRONT_VIDEO}

# youtube-upload \
#     --title="${LAST_MONTH}_BACK" \
#     --description="Timelapse video" \
#     --client-secrets="client_secrets.json" \
#     --playlist="Timelapse Back" \
#     --privacy="private" \
#     ${BACK_VIDEO} 


curl -m 10 --retry 5 https://hc-ping.com/452ac808-5c44-47f0-94dc-aa9e8f5b8210
