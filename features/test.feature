Feature: Complete a Teachable Course

Background:
  Given I am signed up on the Zeachable website

Scenario: Complete a Course
	When I take a course
	Then the course should be set completed