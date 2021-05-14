#! /bin/bash

sudo docker image pull alpine
sudo docker container run -it --memory=10g --cpu-shares=512 alpine
