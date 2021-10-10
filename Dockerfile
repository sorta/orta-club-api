FROM ruby:2.7.0

# RUN apt-get update -qq && apt-get install -y postgresql-client
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

# COPY Gemfile Gemfile.lock ./
# RUN gem install bundler --no-document
# RUN bundle install --no-binstubs --jobs $(nproc) --retry 3

# COPY . .

# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]