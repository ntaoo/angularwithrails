'use strict'

app = angular.module('app', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])

app.config(["$locationProvider", ($locationProvider) ->
  $locationProvider.html5Mode(true)
])

app.config(["$routeProvider", ($routeProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'views/main.html'
    controller: 'MainCtrl'
  .when '/sign_in',
    templateUrl: 'views/sign_in.html'
    controller: 'SignInCtrl'
  .when '/sign_up',
    templateUrl: 'views/sign_up.html'
    controller: 'SignUpCtrl'
  .when '/articles',
    templateUrl: 'views/articles.html'
    controller: 'ArticlesCtrl'
  .otherwise
    redirectTo: '/'
])