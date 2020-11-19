FROM ruby:2.6-alpine

RUN gem install bundler -v '2.1.4'

RUN mkdir -p app && chown 1000:1000 app

RUN apk add --no-cache --update git curl

USER 1000
ENV HOME=/app
WORKDIR /app

COPY --chown=1000:1000 Gemfile* *.gemspec lib/automation_extensions/version.rb /app/
COPY --chown=1000:1000 . /app/

RUN bundle config path /app/vendor && bundle install && bundle clean --force
