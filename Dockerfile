FROM ubuntu:21.04
RUN apt update
RUN apt install -y git zip unzip apt-transport-https wget vim nano
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt update
RUN apt install -y dotnet-sdk-3.1
COPY workflow.sh example/
WORKDIR /example
# RUN vim workflow.sh -c "set ff=unix" -c ":wq"