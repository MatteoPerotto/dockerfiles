# ====================================
# Run commands for deveopement 
# ====================================
xhost +
docker run \
    -it \
    --name $1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e DISPLAY=$DISPLAY \
    -e NVIDIA_DRIVER_CAPABILITIES=all \
    --gpus all \
    --runtime=nvidia \
    ubuntu:gpis_cuda
xhost -
