FROM ruby:3.1

WORKDIR /app

COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--trace", "--host", "0.0.0.0"]