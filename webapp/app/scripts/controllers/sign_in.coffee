'use strict'

angular.module('app').controller('SignInCtrl', ["$scope", "$http", "$location", "Authentication", ($scope, $http, $location, Authentication) ->
  $scope.user = null

  $scope.signIn = () ->
    Authentication.signIn($scope.user.email, $scope.user.password).then(
      (() -> $location.path('/')),
      ((data) ->
        console.log data
      )
    )

])