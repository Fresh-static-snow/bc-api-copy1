FROM ruby:3.0.2-alpine

ARG USER_ID
ARG GROUP_ID

RUN apk --update --no-cache add \
  build-base \
  bash \
  postgresql-client \
  postgresql-dev \
  tzdata \
  git \
  libxml2-dev \
  libxslt-dev \
  libc6-compat \
  less

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN gem install byebug
RUN bundle install --jobs 4

COPY . .

EXPOSE 3000
