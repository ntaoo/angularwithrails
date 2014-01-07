'use strict'

angular.module('app').controller('MainCtrl', ["$scope", "$http", "currentUser", ($scope, $http, currentUser) ->
  $http.get('/api/touch').success((response) ->
    console.log response
  )

  $scope.signOut = () ->
    currentUser.signOut().then((_) ->
      console.log 'sign out'
      console.log _
    )
])
