Feature: Sign Up a new user

  Background: Preconditions
    Given url apiURL

  @SoloUnaPrueba
  Scenario: New user sign up
    Given def userData = {email: "jj11@yopmail.com", password: "jj11@yopmail.com", username: "jj11@yopmail.com"}
    Given path 'users'
    #One line od data
      # And request { user: {email: "#(userData.email)", password: "#(userData.password)", username: "userData.username"} }
    #multidata line
    And request
    """
      {
        "user": {
          "email": "#(userData.email)",
          "password": "#(userData.password)",
          "username": "#(userData.username)"
        }
      }
    """
    When method Post
    Then status 201