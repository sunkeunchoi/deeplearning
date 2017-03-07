#!/bin/bash
sudo nvidia-docker run -it --rm -p 8888:8888 -e "PASSWORD=abc123" -v  `pwd`:/src gpu