ARG DIST
FROM docker.ocf.berkeley.edu/theocf/debian:${DIST}

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
            git \
            lsb-release \
            ruby \
            ruby-dev \
            rubygems \
            ruby-bundler \
            build-essential \
            golang

COPY Gemfile /opt
COPY Gemfile.lock /opt
RUN bundle update --bundler --gemfile=/opt/Gemfile
RUN bundle install --gemfile=/opt/Gemfile

ENV GOCACHE=/tmp
ENV PATH="${PATH}:/usr/lib/go/bin"
# go needs places to put its build files, and the built binaries.
RUN mkdir -m 0777 /opt/go
ENV GOPATH=/opt/go
RUN mkdir -m 0777 /opt/go/bin
ENV GOBIN=/opt/go/bin

COPY package.sh /opt

CMD ["/opt/package.sh"]
