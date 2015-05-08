FROM ruby:2.2.0

RUN mkdir /app

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /app
