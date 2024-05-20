# Short Name Search Backend
This is the backend for the Short Name Search application. It is written in the Ruby programming language and uses the Rails web framework.

## Modes
There are three possible modes to run this application in. You can run the application is a particular mode by setting the `RAILS_ENV` environment variable.

|Mode|Description|
|---|---|
|`development`| This environment will use a SQLite database, stored in the file `storage/development.sqlite3`. You will have to add names to it by using the `POST /contacts` route. |
|`test`| This environment uses a separate SQLite database for testing with two sample records in it. This environment will be used when you run the unit tests.   |
|`production`| This environment uses the PostgreSQL database. Make sure the environment variables are setup, so that the application is able to connect to the PostgreSQL server.|

## CLI commands commands
Make sure you **have Ruby installed** before you continue. The following commands should then be available:

|Command|Description|
|---|---|
| `gem install bundler` | Might be necessary before you begin, to install the Bundler dependency manager. |
| `bundle install` | Installs all necessary dependencies for this project. |
| `bin/rails db:create` | Create the database (needs admin permissions on the database). Can also be done manually in your DB admin tool of choice. |
| `bin/rails db:migrate` | Create all tables in the database that are necessary for running the application. |
| `bin/rails server` | Start the webserver. |
| `rubocop` | Lints the application and shows the results in the console. |
| `rubocop --format html -o lintreport.html` | Lints the application and stores the linting results in the file `lintreport.html`. |
| `bin/rails test` | Runs the unit tests and shows the results in the console. To output a test report to a file, set the `MINITEST_REPORTER` environment variable to `HtmlReporter` |
