'use strict'

angular.module('app').controller('SignUpCtrl', ["$scope", "$http", "$location", "Authentication", ($scope, $http, $location, Authentication) ->
  $scope.user = null

  $scope.signUp = () ->
    Authentication.signUp($scope.user.email, $scope.user.password).then(
      (() -> $location.path('/')),
      ((data) ->
        console.log data
      )
    )
])