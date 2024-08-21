@Nueve
Feature: Articles

  Background: TWO
    * url apiURL
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body
    #Si se ejecuta toda ña prueba con esta linea es mejor solo ejecutar una vez la obtención del token
    #* def tokenResponse = callonce read('classpath:helpers/create_token.feature')
    #sino pues ejecutelo siempre
    #* def tokenResponse = call read('classpath:helpers/create_token.feature')
    #también pueden parametrizarse los valores a cargar, tal como queda en la linea
    #* def tokenResponse = callonce read('classpath:helpers/create_token.feature') {email: "datatestJuan@yopmail.com", password: "datatestJuan@yopmail.com"}
    #* def token = tokenResponse.authToken


  Scenario: Create a new article
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 201
    And match response.article.title == articleRequestBody.article.title

  @file
  Scenario: Create a new article
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 201
    And match response.article.title == 'Carolina 20201'

  Scenario: Create a new article
    Given path 'articles'
    And request {"article": {"title": "Carolina 333","description": "Another test","body": "U know what must be here","tagList": []}}
    When method Post
    Then status 201
    And match response.article.title == 'Carolina 333'

  @JustThisTest
  Scenario: Delete an existing article
    Given path 'articles'
    And request {"article": {"title": "500000","description": "Another test","body": "U know that","tagList": []}}
    When method Post
    Then status 201
    * def articleId = response.article.slug

    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == '500000'

    Given path 'articles',articleId
    When method Delete
    Then status 204

    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != '500000'