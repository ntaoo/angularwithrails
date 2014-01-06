'use strict'

angular.module('app').controller('MainCtrl', ["$scope", "$http", ($scope, $http) ->
  $http.get('/api/touch').success((response) ->
    console.log response
  )
])

