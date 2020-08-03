#!/bin/bash
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/output:/tmp --privileged -t --rm singularityware/docker2singularity yolo 
scp $(ls output/cuda*.simg) rmli223@lcc.uky.edu:cuda_container.simg
