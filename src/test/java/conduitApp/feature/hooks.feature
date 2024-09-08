@NewBlockOfTests
Feature: Hooks

  Background: hooks
    #* def result = call read('classpath:helpers/dummy.feature')
    #solo lo corre una vez y todos los scenarios donde se aplique lo tomarán
    #* def result = callonce read('classpath:helpers/Dummy.feature')
    #* def username = result.username


    * configure afterScenario =
    """
      function(){
        karate.log('after scenario:', karate.scenario.Dummy);
        karate.call('classpath:helpers/dummy.feature', { caller: karate.feature.dummy });
      }
    """


    * configure afterFeature =
    """
      function(){
        karate.log('after scenario2:', karate.scenario.Dummy);
        karate.call('classpath:helpers/dummy.feature', { caller: karate.feature.dummy });
      }
    """

  Scenario: First
    * print 'This is the first scenario'

  Scenario: Second
    * print 'This is the second scenario'