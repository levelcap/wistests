
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
I decided to use this project as an opportunity to get some more experience using Ruby on Rails - I'd previously done some consulting work in an existing Rails application, but had never gone through the exercise of building one up from nothing. This informed some of the design decisions I made along the way, as many of them were exploratory.

For example, instead of building out unit tests early on, I relied on functional testing for the first stages - generating the person model and adding an upload controller with a simple file form frontend, logging inputs and outputs - so that I could be reasonably certain of positive test cases before starting unit tests. This allowed me to approach learning the Minitest framework with more certainty that initial errors were coming from incorrectly formatted tests instead of bugs in the tested code.

I next focused on putting together a robust backend with a sparse frontend, expanding unit tests to cover error cases in the various parsers. I decided to go with an extension model for the different file types - adding in  Comma, Space, and Pipe "PeopleParsers" extended from `BasePeopleParser`. This allowed the parsers to only write new code for things like special parameter handling - parsing dates and pets - or different numbers of expected parameters.

The next step was bringing the frontend up to spec. I opted to utilize [DataTables](https://datatables.net/) for the data display portion, as it not only provides the sorting mechanisms out of the box, it has a number of other features that would be useful in a hypothetical future for the project - searching and pagination in particular. I'd also had previous experience with it, which sped up development on that side of things.

I also used jQuery with the jQuery forms plugin to handle the file upload as a single click-select operation instead of click, select, click-submit. This was based again on expediency based on prior experience, as well what I thought was the desired UX based on the mockup. That also allowed me to render JSON from the file upload controller which contained both successfully added users and any errors generated during parsing. From there I could append new users to the DataTable and display errors related to the file lines that caused the error. It also allows users to upload a file that contains some correct and some incorrect lines.

### Lessons Learned
Don't try to learn a new framework and language while also caring for a new puppy. Nothing breaks a train of thought quite like a hard unexpected bite on the ankle.

I do think this was a good exercise in the balance between time management and learning - while I expected to add some extra time in picking up a new framework, there were some decisions in hindsight that could have saved some ancillary headache. For example, I opted to go with the default SQLite database for ease of configuration, but if I had taken the extra ~10 minutes to get up and running on something I already had worked with and configured - like postgres - I could have saved some lost time just getting setup to manually manipulate the data for functional testing.

### Next Steps
Right now the data model for a Person is over-simple, using strings for every value. This would benefit from being updated to actual types, dates for birthday and an enum for pet types. Aside from being "more correct", it would also allow me to make use of additional validation. Right now, it will assume you have a correctly formatted date for each format, and try to string-replace to obtain the standard format of slashed dates. If you pass in any string though, you can get a nonsense date string.

I'm happy with where the unit testing is for the functionality that exists on the backend, but the project would also benefit from some integration tests that included the frontend.