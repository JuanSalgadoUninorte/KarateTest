@borrador
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
    And match response.tags contains any ['GitHub', 'Git', 'Zoom']
    And match response.tags == "#array"
    And match each response.tags == "#string"

  Scenario: Get 10 articles of the page
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    #response must have a size of 10
    And match response.articles == '#[10]'
    And match response.articlesCount == 11
    And match response.articlesCount != 101
    And match response == { "articles": "#array", "articlesCount": 11 }
    And match response.articles[0].createdAt contains '2024'
    #Iterates in each of these items (of articles) looking for one that confirms that
    And match response.articles[*].favoritesCount != 1
    And match response.articles[*].author.bio contains null
    #Search in the whole response any match with the datahead bio
    And match response..bio contains null
    #Always must be false
    And match each response..following == false
