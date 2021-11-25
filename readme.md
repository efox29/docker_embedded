# Embedded Systems Docker Container

## Build docker image

Please follow the instructions for your own platform and update these instructions if things change.


### Apple M1

`docker buildx build --platform=linux/amd64 -t arm-toolchain --load .`

## Running docker image
### Apple M1
`docker run -it --rm arm-toolchain bash`

## Using docker image