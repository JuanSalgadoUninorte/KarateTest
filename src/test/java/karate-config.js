function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiURL: 'https://conduit-api.bondaracademy.com/api/'
  }
  if (env == 'dev') {
    config.userPassword = 'datatestJuan@yopmail.com'
    config.userEmail = 'datatestJuan@yopmail.com'
  } else if (env == 'qa') {
    config.userPassword = 'jjuan1111@yopmail.com'
    config.userEmail = 'jjuan1111@yopmail.com'
  } else if (env == 'prod') {
    config.userPassword = '15156285@yopmail.com'
    config.userEmail = '15156285@yopmail.com'
  }
  var accessToken = karate.callSingle('classpath:helpers/create_token.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token '+accessToken})
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}