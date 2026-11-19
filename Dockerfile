FROM ruby:4.0-slim

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential \
 && rm -rf /var/lib/apt/lists/* \
 && bundle install

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--trace", "--host", "0.0.0.0"]