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
  .otherwise
    redirectTo: '/'
])