Feature: Articles

  Background: Define URL
    Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'users/login'
    And request {"user": {"email": "datatestJuan@yopmail.com", "password": "datatestJuan@yopmail.com"}}
    When method Post
    Then status 200
    * def token = response.user.token

  Scenario: Create a new article
    Given header Authorization = 'Token '+token
    Given path 'articles'
    And request {"article": {"title": "Just another test \"PART SIX\"","description": "Another test","body": "U know what must be here","tagList": []}}
    When method Post
    Then status 201
    And match response.article.title == 'Just another test \"PART SIX\"'