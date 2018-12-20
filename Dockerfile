FROM docker.ocf.berkeley.edu/theocf/debian:stretch

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
            git \
            ruby \
            ruby-dev \
            rubygems \
            build-essential

# stretch only has golang-1.7 as of Dec 2018.
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends -t stretch-backports \
    golang-1.10

RUN gem install --no-ri --no-rdoc fpm -v 1.10.2

ENV PATH="${PATH}:/usr/lib/go-1.10/bin"

COPY package.sh /tmp

CMD ["/tmp/package.sh"]
