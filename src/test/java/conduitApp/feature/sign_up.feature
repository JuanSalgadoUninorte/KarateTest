Feature: Sign Up a new user

  Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def rUsername = dataGenerator.getRandomUsername()
    * def rEmail = dataGenerator.getRandomEmail()
    Given url apiURL

  @SoloUnaPrueba2
  Scenario: New user sign up
    #Given def userData = {email: "jj11@yopmail.com", password: "jj11@yopmail.com", username: "jj11@yopmail.com"}
    #* def jsFunc =
    #"""
    #  function () {
    #    var DataGenerator = Java.type('helpers.DataGenerator')
    #    var generator = new DataGenerator()
    #    return generator.getRandomUsernameNonStatic()
    #  }
    #"""
    #* def randomUsernameNonStatic = call jsFunc
    Given path 'users'
    #One line od data
      # And request { user: {email: "#(userData.email)", password: "#(userData.password)", username: "userData.username"} }
    #multidata line
    * print rEmail
    And request
#    """
#      {
#        "user": {
#          "email": "#(userData.email)",
#          "password": "#(userData.password)",
#          "username": "#(userData.username)"
#        }
#      }
#    """
    """
      {
        "user": {
          "email": "#(rEmail)",
          "password": "#(userData.password)",
          "username": "#(rUsername)"
        }
      }
    """
    When method Post
    Then status 201
    And match response ==
    """
    {
      "user": {
          "id": '#number',
          "email":  "#(rEmail)",
          "username": "#(rUsername)",
          "bio": null,
          "image": "#string",
          "token": "#string"
      }
    }
    """

  Scenario Outline: New user sign up - Outline
    Given path 'users'
    And request
    """
      {
        "user": {
          "email": "<email>",
          "password": "<password>",
          "username": "<username>"
        }
      }
    """
    When method Post
    Then status 422
    And match response == <errorMessage>

    Examples:
      | email                   | password | username     | errorMessage                                                                          |
      | #(rEmail)               | 234567   | 23456789kkk  | {"errors":{"username":["has already been taken"]}}                                    |
      | stevielesch22@testj.com | 234567   | #(rUsername) | {"errors":{"email":["has already been taken"]}}                                       |
      | stevielesch22@testj.com | 234567   | 23456789kkk  | {"errors":{"email":["has already been taken"],"username":["has already been taken"]}} |
      | #(rEmail)               | 234567   |              | {"errors":{"username":["can't be blank"]}}                                            |
      |                         | 234567   | #(rUsername) | {"errors":{"email":["can't be blank"]}}                                               |
      | #(rEmail)               |          | #(rUsername) | {"errors":{"password":["can't be blank"]}}                                            |