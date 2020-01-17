FROM python:alpine
WORKDIR /build-everylotbot
RUN apk add --no-cache git
RUN git clone https://github.com/fitnr/everylotbot.git .
RUN python setup.py install

WORKDIR /build-s3cmd
ADD https://github.com/s3tools/s3cmd/releases/download/v2.0.2/s3cmd-2.0.2.tar.gz .
RUN tar -xzf *.tar.gz
WORKDIR /build-s3cmd/s3cmd-2.0.2
RUN python setup.py install

WORKDIR /db
RUN rm -rf /build-everylotbot
RUN rm -rf /build-s3cmd

COPY db/*.tar.gz .
RUN tar -xzf *.tar.gz
RUN rm ./*.tar.gz

ENTRYPOINT ["everylot"]
