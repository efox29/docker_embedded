# Embedded Systems Docker Container

## Build docker image

Please follow the instructions for your own platform and update these instructions if things change.


To build image run the command
**BE SURE TO CHANGE THE VERSION NUMBER**
`./build_me.sh`

When working to push to dockerhub
`docker push IMAGE_NAME`

To update to latest tag, run the script `update-latest-tag.sh` and pass in argument.

## Running docker image
Copy the `start_docker.sh` to your project folder and run from there. I have a folder called scripts, which I place this, and I modify the paths in the script to be the root of the project. The path needs to be the root of your project.



