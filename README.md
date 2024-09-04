Reference & Guideline of this project
point1
Add data to the backend
As I was window user, it was lot hard to install ruby first. installed ruby 3.3.1 version with rbenv, which is manager of ruby. And installed related bundle with command 'bundle install' . And to run the ruby application, marked ruby interpreter and ENV (development).
To add the contacts to the database(sqlite3), edited add_contacts.sh file.
In add_contacts.sh, there are three empty arrays (fullnames=(),emails=(),shortnames=()) that will store parsed data in data.txt file. And before doing all of these procedure, it checks whether the database is empty, so if it is not empty, it just exits itself. Hyeri https://curl.se/docs/ https://stackoverflow.com/questions/53284143/what-is-a-curl-and-how-do-i-execute-it
point2
Frontend and Backend dockerfiles were created. Backend file uses Ruby image, generates a gemfile and copies all the backend contents into the container. Then, sets the environment to production and exposes port 3000, while setting up the Ruby. Frontend dockerfile builds the application and sets up nginx proxy using ports 8080 and 80. dockerize script was also created, which can be ran by build, run, stop commands. Filip https://docs.docker.com/reference/dockerfile/ https://nginx.org/en/docs/ https://stackoverflow.com/questions/31676155/docker-error-response-from-daemon-conflict-already-in-use-by-container

point3
Inside the docker-compose there is an additional volume for database created as well as for the script. The docker compose sets environment variables in backend and mysql for connection, and performs healthchecks for each crucial container. The environment is set to production, and an additional dockerfile for seed-application is created for adding contacts to the database. Filip https://docs.docker.com/reference/dockerfile/ https://docs.docker.com/compose/ https://stackoverflow.com/questions/71435415/docker-compose-up-error-without-information

point4
stages : lint, test
job1 : lint-frontend
installed npm and made new file (txt) and wrote the result there
job2 : lint-backend
installed ruby and gem and matched their versions as same
and wrote the result in new file (txt)
job3 : unit-test
tried setting .env 'MINITEST_REPORTER=HtmlReporter' but it keeps saying error like this
➜ backend git:(main) ✗ ./bin/rails test /home/hyeri/.rbenv/versions/3.3.1/lib/ruby/3.3.0/bundled_gems.rb:74:in `require': cannot load such file -- minitest/reporters (LoadError) Hyeri https://docs.gitlab.com/ee/ci/
point5
made terraform file
1 vpc, t2.large instance and a launch template
user_data.sh : docker-compose up to download docker compose, run the whole application, make initial script for getting instance ip Hyeri, Filip https://developer.hashicorp.com/terraform/docs https://registry.terraform.io/providers/hashicorp/aws/latest/docs https://terraform-docs.io/
point6
Added deploy stage, which builds, pushes and deploys the docker images, logs into docker, builds the images for docker and sets up SSH keys Filip https://docs.gitlab.com/ee/ci/ https://stackoverflow.com/questions/78562076/fetch-image-from-registry-and-use-it-in-pipeline https://stackoverflow.com/questions/78561643/docker-manifest-inspect-not-working-as-expected https://stackoverflow.com/questions/78557829/editing-my-cnf-for-mysql-service-container-in-gitlab-ci

point7
Added loadbalancer, autoscaling group and s3 bucket, the deployment is automatical, no need to manually create instances Hyeri, Filip https://developer.hashicorp.com/terraform/docs https://registry.terraform.io/providers/hashicorp/aws/latest/docs https://terraform-docs.io/
