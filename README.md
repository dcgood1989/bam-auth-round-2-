# BAM! (Benchmark Assessment Mondays) - CRUD with User Authentication, Round 2

## Setup

* If you modified (`~/.gschool.json`) this since the last BAM!, go to your profile on students.gschool.it (click your name, My Profile), click on the "Download Exercise File" under Exercises. Move that file to your root directory (`~/`) under the name `.gschool.json`. If you downloaded the file to your Downloads directory, this should do it: `mv ~/Downloads/gschool.json ~/.gschool.json`.

* Fork and clone this repository, `rake db:create`, etc.

* When you are finished, ***open a pull request to submit your work.***

## Steps

In this benchmark, there are 4 feature specs. The file names imply an enumeration that we ***strongly suggest***, but *do not mandate*, you follow. A reminder/hint that the spec files provide the *specifications of behavior* for the application, so they *may* (might, maybe, conceivably, reasonably) be a good starting point.

Again the goal is to remain calm and work your way through errors as they arise. If you hit an absolute brick wall please take note of it and ask an instructor for assistance, but the goal is to never have to do this.

## Quick overview

In this application we are building software to help a warehouse manager keep track of shovels. Users will be instructed to click links to log in or register from the homepage. An authenticated user will then see an index view for shovels (which have a `name` and `quantity`), as well as links to the associated CRUD functionality for shovels. Unauthenticated users are unable to see or operate on shovels.

## Warning

***DO NOT*** modify any test files.

## Hints

A helpful command to know is that you can run an individual RSpec file as so:

```
rspec [relative/path/to/spec]
```

for example in this repository:

```
rspec spec/features/0_user_signup_spec.rb
```

It *may* (might, maybe, conceivably, reasonably) be helpful to work through each of the specs in order, rather than trying to work through them all at once.

If you are finding the output of even the single file to be too much to handle, another helpful hint is that you can run individual specs by providing the line number of the `scenario` block in the file, so to run the first test, in isolation:

```
rspec spec/features/0_user_signup_spec.rb:6
```

For your convenience, the `pry` gem has already been added to the `Gemfile` - this is a great way to help in understanding what is going wrong in addition to using `save_and_open_page`.
