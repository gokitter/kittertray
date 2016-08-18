@meow
Feature: Say Meow
	In order to ensure quality
	As a user
	I want to be able to test functionality of my API

Background:


Scenario: Meow with message returns ok
	Given I send and accept JSON
	When I send a POST request to the api endpoint "/v1/meow" with
    | meow | tester |
	Then the response status should be "200"