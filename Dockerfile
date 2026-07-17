# Ref. https://docs.docker.com/compose/rails/
FROM ruby:3.2.11

WORKDIR /app

# mysql CLI is required to load structure.sql (db:structure:load)
# chromium and chromium-driver are for system tests (headless)
RUN apt-get update \
    && apt-get install -y --no-install-recommends default-mysql-client \
       chromium chromium-driver \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 2.3.27

ARG BUNDLE_INSTALL_ARGS="-j 4"
COPY Gemfile Gemfile.lock ./
RUN bundle _2.3.27_ install ${BUNDLE_INSTALL_ARGS}

COPY . ./

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
