FROM python:alpine
WORKDIR /build
RUN apk add --no-cache git
RUN git clone https://github.com/fitnr/everylotbot.git .
RUN python setup.py install

WORKDIR /db
RUN rm -rf /build
COPY db/*.tar.gz .
RUN tar -xzf *.tar.gz
RUN rm ./*.tar.gz

ENTRYPOINT ["everylot"]
