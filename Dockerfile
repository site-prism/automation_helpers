FROM ruby:2.6-alpine

RUN gem install bundler -v '2.1.4'

RUN mkdir -p app && chown 1000:1000 app

USER 1000
ENV HOME=/app

WORKDIR /app

COPY --chown=1000:1000 Gemfile* /app/

# NOTE If running through Jenkins - This will configure internal nexus redirects
RUN [ -n "${CA_INTERNAL_NETWORK+set}" ] && \
  bundle config mirror.https://rubygems.org https://nexus.devops.citizensadvice.org.uk/repository/rubygems-proxy && \
  bundle config mirror.https://rubygems.org.fallback_timeout 1 && \
  bundle config mirror.https://rails-assets.org https://nexus.devops.citizensadvice.org.uk/repository/rails-assets.org && \
  bundle config mirror.https://rails-assets.org.fallback_timeout 1; true && \
  bundle config path /app/vendor

RUN bundle install && bundle clean --force

COPY --chown=1000:1000 . /app/
