# README

* Clone the project into the desired location
* Insatll or update the proper ruby verison.
* Enter the app directory `cd app`
* Install the Bundler gem byt typing `gem install bundler` into the console.
* Set up the database by running `rake db:setup` and start the server by `rails s`
* Ruby 2.7.5
* Rails 5.2.7
* Database Postgres

# IMP INFO

* Enter the url `https://www.visitberlin.de/en/event-calendar-berlin` int the `Enter events url:` and hit submit.

* It will take tiime to scrape all the Events related info lie `title` `date` `place` and `description`

* After scrapping it will `bulk import the records in db`

* Search the events based on `title`

# Scrapper
Fetch the information related to cultural activities in Berlin into one site
