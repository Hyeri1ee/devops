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

## point2

### backend

- dockerfile
  - 

### frontend

- in frontend README.md, there is instruction of doing some stuff.
  - npm install, npm run dev, npm run build
- customize configuration
  - changed server's port from 6000 to 3000 because backend's url is 3000
  - set VITE_REST_API as 'http://localhost:3000/' which is related to backend url
- dockerfile
  - 

## point3

## point4
- stages : lint, test
- job1 : lint-frontend
  - 