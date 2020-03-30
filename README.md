# ffmpeg-android-maker-docker

The purpose of this repository is to build [ffmpeg-android-maker](https://github.com/Javernaut/ffmpeg-android-maker/) inside a Docker container without the need to install any build dependencies. It also enables easier build support on Windows.

The build output is copied to /ffmpeg-android-maker/build. This should be mounted to a folder on the host machine.

## Build image

You only need to do this once unless you need to change SDK/NDK versions. The contains all the necessary build tools:

```sh
docker build --rm --tag ffmpeg-android-maker:latest .
```

## Building ffmpeg with container

### Prerequisites

You have two options for running the container.

1. Set the *ANDROID_MAKER_COMMIT* environment variable to download a specific commit of ffmpeg-android-maker from Github.
   
   This is best for those who just want to build ffmpeg.

2. Mount /ffmpeg-android-maker as a volume to a checked out copy of ffmpeg-android-maker on your host machine.
 
   This is best for those who want to develop ffmpeg-android-maker allowing you to run it without having to commit your code first.

Only set one of these.

### Building

This will download ffmpeg, build it, and then copy the output to /build:
```sh
docker container run --rm \
  -e EXTRA_BUILD_CONFIGURATION_FLAGS=--disable-gpl \
  -e ANDROID_MAKER_COMMIT=d668263fafdecb039e22daf3b5e2d01d4d6e1502 \
  -v /path/to/build/output:/ffmpeg-android-maker/build \
  ffmpeg-android-maker
```

On Windows you can pass in a host path in the following way:
```sh
-v C:\path\to\host\output:/ffmpeg-android-maker/build
```

### Docker-compose
You can also run the container using docker-compose.

Add the following to docker-compose.yml:

```yaml
version: '2.3'
services:
    ffmpeg-android-maker:
    image: ffmpeg-android-maker:latest
    container_name: ffmpeg-android-maker
    environment:
        EXTRA_BUILD_CONFIGURATION_FLAGS: --disable-gpl
        ANDROID_MAKER_COMMIT: d668263fafdecb039e22daf3b5e2d01d4d6e1502
    volumes:
        - /path/to/build/output:/ffmpeg-android-maker/build
```

And then run using

```sh
docker-compose up -d
```

## Environment variables
The following environment variables can be set to adjust behaviour:

| Variable 					              | Description 	                                                            |
| ----------------------------------------|-----------------------------------------------------------------------------|
| EXTRA_BUILD_CONFIGURATION_FLAGS         | Pass any additional build arguments, e.g, --disable-gpl                     |
| ANDROID_MAKER_COMMIT                    | If set this commit of ffmpeg-android-maker will be downloaded from Github   |
