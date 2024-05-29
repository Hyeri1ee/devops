FROM ruby:3.3.1

RUN apt-get update -qq && apt-get install -y nodejs yarn mariadb-server sqlite3 libsqlite3-dev

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

ENV RAILS_ENV=development

CMD ["bash", "-c", "bundle exec rake db:migrate && rm -f /app/tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0"]
