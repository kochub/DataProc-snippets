FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
RUN useradd -ms /bin/bash --uid 1000 jupyter\
&& apt update\
&& apt install -y unzip python3.9-dev python3.9-distutils curl\
&& ln -s /usr/bin/python3.9 /usr/local/bin/python3\
&& curl https://bootstrap.pypa.io/get-pip.py | python3\
&& curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
&& unzip awscliv2.zip \
&& ./aws/install