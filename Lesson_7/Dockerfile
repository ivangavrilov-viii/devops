FROM ubuntu:18.04
RUN apt update
RUN apt install git
RUN git clone https://github.com/ivangavrilov-viii/devops.git
RUN mv devops/Lesson_7/requirements.txt /tmp/
RUN mv devops/Lesson_7/app.py /opt/webapp
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-all python-pip
WORKDIR /opt/webapp/
RUN pip install -qr requirements.txt
EXPOSE 5000