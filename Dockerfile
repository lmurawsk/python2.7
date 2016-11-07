FROM python:2.7.12-slim

    # update apk and install git
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get update --fix-missing && \
    apt-get install -y wget ca-certificates vim git

#   Add Tini - tini 'init' for containers
RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

RUN pip install --upgrade pip && \
    pip install pika
	
ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/bin/bash"]
