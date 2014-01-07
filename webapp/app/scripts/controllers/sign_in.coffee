'use strict'

angular.module('app').controller('SignInCtrl', ["$scope", "$http", "$location", ($scope, $http, $location) ->
  $scope.user = null

  $scope.signIn = () ->
    $http.post('/api/sessions', { session: { email: $scope.user.email, password: $scope.user.password } })
    .success((data) ->
        console.log 'signed in'
        console.log data.info
        $scope.$broadcast('event:authenticated')
        $location.path('/')
      )
    .error((reason) ->
        console.log 'error'
        $scope.user.errors = reason
      )
])