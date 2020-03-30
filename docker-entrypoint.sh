#!/usr/bin/env bash

if [ "${ANDROID_MAKER_COMMIT}" ]; then
  url="https://github.com/Javernaut/ffmpeg-android-maker/archive/${ANDROID_MAKER_COMMIT}.zip"
  echo Downloading commit $url
  wget -q -O /tmp/ffmpeg-android-maker.zip $url && \
  unzip -q -d /tmp/ffmpeg-android-maker /tmp/ffmpeg-android-maker.zip && \
  mv /tmp/ffmpeg-android-maker/*/* .
fi

runFile=ffmpeg-android-maker.sh
if [ -f "$runFile" ]; then
  chmod u+x ./$runFile
  ./$runFile
else
	echo -e "\e[31m$runFile does not exist. Did you forget to mount /ffmpeg-android-maker or set ANDROID_MAKER_COMMIT?\e[0m"
	exit 1
fi