Feature: Test for the home page

  Background: Define URL
    Given url 'https://conduit-api.bondaracademy.com/api/'

  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains 'GitHub'
    And match response.tags !contains 'cars'
    And match response.tags == "#array"
    And match each response.tags == "#string"

  Scenario: Get 10 articles of the page
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    #response must have a size of 10
    And match response.articles == '#[10]'
    And match response.articlesCount == 10

# Scenario: Create a user
 #   Given path 'users'
  #  And request {"user": {"email": "datatestJuan221222@yopmail.com","password": "datatestJuan2221222@yopmail.com","username": "datatestJuan1212"}}"
   # When method Post
    #Then status 201