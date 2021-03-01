FROM ruby:2.7-alpine

RUN gem install bundler -v '2.1.4'

RUN mkdir -p app && chown 1000:1000 app

RUN apk add --no-cache --update build-base git

USER 1000
ENV HOME=/app
WORKDIR /app

COPY --chown=1000:1000 Gemfile* *.gemspec /app/
COPY --chown=1000:1000 lib/ca_testing/version.rb /app/lib/ca_testing/

RUN bundle config path /app/vendor && bundle install && bundle clean --force > /dev/null 2>&1

COPY --chown=1000:1000 . /app/
