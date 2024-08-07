Feature: Create token

  Scenario: Create token
    Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'users/login'
    # Así es parametrizado
    And request {user: {email: '#(email)', password: '#(password)'}}
    #And request {"user": {"email": "datatestJuan@yopmail.com", "password": "datatestJuan@yopmail.com"}}
    When method Post
    Then status 200
    * def authToken = response.user.token