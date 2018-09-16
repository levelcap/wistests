
# README

A Rails 5 application that takes a list of people via file upload, parses them, persists them to a database, and displays them in a sortable table on a web page.

## Setup
This project requires Ruby, Rails and SQLite

 - Check your SQLite version: `sqlite3 --version`. If it is not installed, follow the instructions on the SQLite site: https://www.sqlite.org/index.html
 - Install Rails by running `gem install rails`
 - Check your Rails version by running `rails --version`
 - Install Ruby bundles by running `bundle install` in the `full-stack/` directory.

## Running

 - The application will run at http://localhost:3000 by default. You can change this by either modifying the default value in `full-stack/config/puma.rb` or by setting the `PORT` environmental variable.
 - Start the application by running `rails server` in the `full-stack/` directory
 - You can find test files for upload in `full-stack/test/fixtures/files/`

## Testing
- Tests can be found in `full-stack/test/`
- Start tests by running `rails test`

## Project Breakdown
