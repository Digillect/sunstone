FROM ruby:3.0-alpine3.16

# Install Bundler 2.0
RUN gem install bundler

# Prepare data directory
RUN mkdir -p /data
VOLUME /data

COPY gems.rb gems.locked /usr/local/sunstone/
WORKDIR /usr/local/sunstone
RUN bundle config set without development test && bundle install

COPY bin/sunstone-docker.sh /usr/local/bin/sunstone
COPY sunstone.rb /usr/local/sunstone/
COPY lib /usr/local/sunstone/lib/
WORKDIR /data

CMD ["sunstone", "--help"]
