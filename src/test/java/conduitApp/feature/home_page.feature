Feature: Test for the home page

  Background: Define URL ONE
    Given url apiURL

  @skipme
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
