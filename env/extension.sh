#!/bin/bash

#Install Driver and nvidia-docker
sudo apt-get install -qq linux-headers-`uname -r`
sudo chmod +x /tools/NVIDIA-Linux-x86_64-375.20.run
sudo sh /tools/NVIDIA-Linux-x86_64-375.20.run -a -s
sudo dpkg -i /tools/nvidia-docker_1.0.0.rc.3-1_amd64.deb

#Get sources and build a docker image
cd /home/agent
sudo git clone https://github.com/wbuchwalter/on-demand-training-vsts
cd on-demand-training-vsts
echo "1" > ./1.txt
sudo docker build -f Dockerfile.train -t cntk-mnist .
echo "2" > ./2.txt
#Run the training, with a volume to save output
sudo nvidia-docker run cntk-mnist
