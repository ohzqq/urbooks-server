# step 1
FROM ruby:3.0.2 AS base

## System dependencies
RUN apt-get update -qq && apt-get install -y \
  sqlite3 \
  tzdata \
	libxml2-dev \
  libxslt-dev

# step 2
FROM base AS dependencies

RUN apt-get install -y build-essential

COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test'
RUN bundle install --jobs=3 --retry=3

# step 3
FROM base

RUN adduser urbooks
USER urbooks
WORKDIR /home/urbooks

COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/
COPY --chown=urbooks . ./
# Step 4
EXPOSE 9292
