# Takehome for QA engineer position.

This is a completed cucumber project for the Takehome QA Test

## Goal

We created a test school with a course that contains 4 lecture.
Your task is to write tests where you enroll in a course and complete it.
Please use Cucumber with Capybara

## Thoughts

This is my first foray using Capybara, I noticed the driver interactions are a lot more user friendly than when using Watir. I also felt like there was less of a need for page objects so I did not include them. I also believe page objects are better iterated into than created from the ground up. I also took the more classic BDD approach where the scenarios are not that detailed. If it is the goal for a product manager to write scenarios then this is my preferred way to create the feature files.
## Assumptions

- Built and tested against ruby 2.4.0p0
- Built and tested on a Mac Running High Sierra
- Must have an internet connection
- We do not have access to the database so unique test users are created on the fly (there is no cleanup for this)
- User has chrome browser installed
- This test is only built for chrome as Capybara was having problems starting Firefox on my local machine.

## Blockers/Bugs
There were a few issues found while writing this test.
- I think there is a quiz at the end of the course, this threw a 400 error and the quiz never populated, so the last page on the course would not show 100%, the work around is to just hit the back button.
- The start next lecture button at the end of the course did not work, there is only one course though and this might be a bug of the previous issue.
- Firefox would not function correctly with Capybara on my machine so I did not write in a browser switcher.

## Setup

run in the project root
```
gem install bundler
```

```
bundle install
```
```
cucumber
```

## Linting
I used Rubocop for linting and all the config for that is located in .rubocop.yml
run rubocop in the project root
```
gem install rubocop
rubocop
```
## Test school base url:

* [takehome.zeachable.com](http://takehome.zeachable.com)

