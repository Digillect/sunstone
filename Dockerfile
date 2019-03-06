FROM ruby:2.5-alpine3.8

# Install Bundler 2.0
RUN gem install bundler

# Prepare data directory
RUN mkdir -p /data/input /data/output
VOLUME /data/input /data/output

COPY Gemfile Gemfile.lock /usr/local/sunstone/
WORKDIR /usr/local/sunstone
RUN bundle install --without development test

COPY bin/sunstone /usr/local/sunstone/bin/
COPY bin/sunstone.sh /usr/local/bin/sunstone
COPY lib /usr/local/sunstone/lib/

CMD ["/usr/local/bin/sunstone", "-po", "/data/output", "/data/input"]
