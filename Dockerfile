FROM ruby:2.7.4-slim

# Install SDL2
RUN apt-get update && \
  apt-get install -y libsdl2-dev libgl1-mesa-dev libopenal-dev libgmp-dev libfontconfig1-dev libgtest-dev libmpg123-dev libsndfile1-dev

# Install Ruby development tools
RUN apt-get install -y ruby-dev ruby-build

WORKDIR /usr/src/app

# Install Ruby depenencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy source
COPY . .