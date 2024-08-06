Feature: Articles

  Background: TWO
    Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'users/login'
    And request {"user": {"email": "datatestJuan@yopmail.com", "password": "datatestJuan@yopmail.com"}}
    When method Post
    Then status 200
    * def token = response.user.token

  Scenario: Create a new article
    Given header Authorization = 'Token '+token
    Given path 'articles'
    And request {"article": {"title": "Carolina 333","description": "Another test","body": "U know what must be here","tagList": []}}
    When method Post
    Then status 201
    And match response.article.title == 'Carolina 333'

  Scenario: Delete an existing article
    Given header Authorization = 'Token '+token
    Given path 'articles'
    And request {"article": {"title": "500000","description": "Another test","body": "U know that","tagList": []}}
    When method Post
    Then status 201
    * def articleId = response.article.slug

    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != '500000'


    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == '500000'

    Given header Authorization = 'Token '+token
    Given path 'articles'+articlesId
    When method Delete
    Then status 204

