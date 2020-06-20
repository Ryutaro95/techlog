FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential nodejs vim

ENV LANG C.UTF-8

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN mkdir -p tmp/sockets