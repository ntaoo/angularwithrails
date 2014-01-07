'use strict'

angular.module('app').controller('MainCtrl', ["$scope", "$http", "currentUser", "$location", ($scope, $http, currentUser, $location) ->
  $http.get('/api/touch')

  $scope.signOut = () ->
    currentUser.signOut().then(
      (() ->
        console.log 'signed out'
        $location.path('/sign_in')
      ),
      ((data) ->
        console.log data
      )
    )
])
