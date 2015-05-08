FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential

RUN mkdir /app

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /app
