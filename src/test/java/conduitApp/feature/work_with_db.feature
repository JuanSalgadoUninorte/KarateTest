Feature: work with DB

  Background: Connect to DB
    * def dbHandler = Java.type('helpers.DBHandler')

  Scenario: Seed database with a new Job
    * eval dbHandler.addNewJobWithName('Qa3')

  @Database
  Scenario: Get level for Job
    * def level = dbHandler.getMinAndMaxLevelsForJob('Publisher')
    * print level.minLvl
    * print level.maxLvl
    And match level.maxLvl == '250'
    And match level.minLvl == '150'