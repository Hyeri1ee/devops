# Reference & Guideline of this project

## point1

1. Add data to the backend
- As I was window user, it was lot hard to install ruby first. installed ruby 3.3.1
  version with rbenv, which is manager of ruby. And installed related bundle with command 'bundle install'
  . And to run the ruby application, marked ruby interpreter and ENV (development).
- To add the contacts to the database(sqlite3), edited add_contacts.sh file.
- In add_contacts.sh, there are three empty arrays (fullnames=(),emails=(),shortnames=()) that will store parsed data in
  data.txt file. And before doing all of these procedure, it checks whether the database is empty, so if it is not empty,
  it just exits itself.
  Hyeri

## point2 

Frontend and Backend dockerfiles were created. Backend file uses Ruby image, generates a gemfile and copies all
the backend contents into the container. Then, sets the environment to production and exposes port 3000, while
setting up the Ruby. Frontend dockerfile builds the application and sets up nginx proxy using ports 8080 and 80.
dockerize script was also created, which can be ran by build, run, stop commands.
Filip

## point3

Inside the docker-compose there is an additional volume for database created as well as for the script. The
docker compose sets environment variables in backend and mysql for connection, and performs healthchecks for each 
crucial container. The environment is set to production, and an additional dockerfile for seed-application is created
for adding contacts to the database.
Filip

## point4
- stages : lint, test
- job1 : lint-frontend
    - installed npm and made new file (txt) and wrote the result there
- job2 : lint-backend
    - installed ruby and gem and matched their versions as same
    - and wrote the result in new file (txt)
- job3 : unit-test
    - tried setting .env 'MINITEST_REPORTER=HtmlReporter' but it keeps saying error like this
        - ➜  backend git:(main) ✗ ./bin/rails test
          /home/hyeri/.rbenv/versions/3.3.1/lib/ruby/3.3.0/bundled_gems.rb:74:in `require': cannot load such file -- minitest/reporters (LoadError)
Hyeri

## point5
- made terraform file
- 1 vpc, t2.large instance and a launch template
- user_data.sh : docker-compose up to download docker compose, run the whole application, make initial script for getting instance ip
Hyeri, Filip

## point6

## point7
Added loadbalancer, autoscaling group and s3 bucket, the deployment is automatical, no need to manually create instances
Hyeri, Filip