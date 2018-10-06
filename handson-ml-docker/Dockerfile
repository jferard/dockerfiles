FROM fedora

EXPOSE 8888

RUN dnf -y update && dnf install -y git && dnf clean all

RUN useradd handson

USER handson

ENV PATH="/home/handson/.local/bin:${PATH}"

RUN pip3 install --user --upgrade pip

RUN cd /home/handson && git clone https://github.com/ageron/handson-ml.git

RUN cd /home/handson/handson-ml && pip3 install --user --upgrade -r requirements.txt

RUN jupyter contrib nbextension install --user

RUN jupyter nbextension enable toc2/main
