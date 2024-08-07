Feature: Create token

  Scenario: Create token
    Given url apiURL
    Given path 'users/login'
    # Así es parametrizado
    And request {user: {email: '#(userEmail)', password: '#(userPassword)'}}
    #And request {"user": {"email": "datatestJuan@yopmail.com", "password": "datatestJuan@yopmail.com"}}
    When method Post
    Then status 200
    * def authToken = response.user.token