FROM ruby:2.5-alpine3.8

# Install Bundler 2.0
RUN gem install bundler

# Prepare data directory
RUN mkdir -p /data/input /data/output
VOLUME /data/input /data/output

COPY Gemfile Gemfile.lock /tmp/
WORKDIR /tmp
RUN bundle install --without development test

COPY bin /app/bin/
COPY lib /app/lib/
COPY Gemfile Gemfile.lock /app/
WORKDIR /app

ENTRYPOINT ["/usr/bin/env", "ruby", "/app/bin/sunstone"]
CMD ["-po", "/data/output", "/data/input"]
