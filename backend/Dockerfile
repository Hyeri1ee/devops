## Dockerfile
## build and run dockerfile in retake folder (not in backend folder)
FROM ruby:3.3.1
RUN mkdir /myapp
WORKDIR /myapp

COPY ./backend/Gemfile /myapp/Gemfile
COPY ./backend/Gemfile.lock /myapp/Gemfile.lock
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN bundle install
COPY ./backend /myapp

# Add a script to be executed every time the container starts.
COPY ./seed-application/add_contacts.sh /usr/bin/
RUN chmod +x /usr/bin/add_contacts.sh
ENTRYPOINT ["/usr/bin/add_contacts.sh"]
ENV RAILS_ENV=production
EXPOSE 3000

# Start the main process.
CMD ["./backend/bin/rails", "server","-b0.0.0.0"]