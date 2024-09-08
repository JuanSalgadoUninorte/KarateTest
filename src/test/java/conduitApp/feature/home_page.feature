@borrador @parallel=false
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
    * def isValidTime = read('classpath:helpers/schema-like-time-validator.js')
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match each response.articles ==
	"""
		{
			"slug": '#string',
			"title": '#string',
			"description": '#string',
			"body": '#string',
			"tagList": '#array',
			"createdAt": '#? isValidTime(_)',
			"updatedAt": '#? isValidTime(_)',
			"favorited": '#boolean',
			"favoritesCount": '#number',
			"author": {
				"username": '#string',
				"bio": '##string',
				"image": '#string',
				"following": '#boolean'
			}
	    }
	"""
    #response must have a size of 10
    And match response.articles == '#[10]'
    And match response.articlesCount == 42
    And match response.articlesCount != 101
    And match response == { "articles": "#array", "articlesCount": '#number' }
    And match response.articles[0].createdAt contains '2024'
    #Iterates in each of these items (of articles) looking for one that confirms that
    And match response.articles[*].favoritesCount != 1
    And match response.articles[*].author.bio contains null
    #Search in the whole response any match with the datahead bio
    And match response..bio contains null
    #Always must be false
    And match each response..following == false
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#number'
    #The double hash means that it can be a null or a string
    And match each response..bio == '##string'

  @NewTest28
  Scenario: Conditional Logic
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount
    * def article = response.articles[0]
    * def result = favoritesCount == 0 ? karate.call('classpath:helpers/add_likes.feature', article).likesCount : favoritesCount

    #* if ( favoritesCount==0 ) karate.call('classpath:helpers/add_likes.feature', article)
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == result

  Scenario: Retry Call
    * configure retry = { count: 10, interval: 5000 }
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    #condition to the retrial ALWAYS BEFORE THE METHOD
    And retry until response.articles[0].favoritesCount == 1
    When method Get
    Then status 200

  Scenario: Sleep Call
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    * eval sleep(10000)
    Then status 200

  Scenario: Number to String
    * def foo = 10
    #number to string
    * def json = { "bar": #(foo+'') }
    * match json == { "bar": '10' }

  @NewTest29
  Scenario: String to number
    * def foo = '10'
    #string to number 1
    * def json = { "bar": #(foo*1) }
    #string to number 2
    * def json2 = { "bar": #(parseInt(foo)) }
    * def json3 = { "bar": #(~~parseInt(foo)) }
    * match json == { "bar": 10 }
    * match json2 == { "bar": 10 }
    * match json3 == { "bar": 10 }