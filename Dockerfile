FROM ruby:2.5-alpine

WORKDIR /cap

ADD Gemfile /cap

RUN apk --no-cache add curl ca-certificates bash git openssh
RUN bundle install
RUN mkdir -p /root/.ssh

COPY deploy.sh /cap/deploy.sh
COPY ssh_config /cap/ssh_config

ENTRYPOINT ["/bin/bash"]
CMD ["/cap/deploy.sh"]
