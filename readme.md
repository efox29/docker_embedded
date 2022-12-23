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

## Copying to another repo 
If you want to push this to another repo, then the easiest way is to

1. Make sure you are logged into the account that you want to push to.

```
docker login
```

Enter the username and pass. Username is not the email address of the account. I made that mistake a few times.

2. Copy the docker image id to do a new tag.

```
docker images
```
Find the image you want to push to another repo

3. Create a new tag with the new repository name

```
docker tag 97823d3 company/arm-toolchain:v1.3.0
```

4. Push.

```
docker push company/arm-toolchain:v1.3.0
```





