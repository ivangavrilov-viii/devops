FROM ubuntu:18.04
RUN apt update
RUN apt install git -y
RUN git clone https://github.com/ivangavrilov-viii/devops.git
RUN mv devops/Lesson_7/requirements.txt /tmp/
WORKDIR /opt/webapp/
RUN mv /devops/Lesson_7/app.py /opt/webapp
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-all python-pip
RUN pip install -qr /tmp/requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]