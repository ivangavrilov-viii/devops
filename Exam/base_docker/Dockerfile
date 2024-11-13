FROM ubuntu:18.04

RUN apt update && apt install git unzip wget docker.io -y
RUN git clone https://github.com/ivangavrilov-viii/devops.git /devops
RUN mv /devops/Exam/.terraformrc .

RUN wget https://hashicorp-releases.yandexcloud.net/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip &&  \
    unzip terraform_1.9.8_linux_amd64.zip &&  \
    mv terraform /bin &&  \
    rm -r terraform_1.9.8_linux_amd64.zip