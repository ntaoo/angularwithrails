'use strict'

angular.module('app').controller('MainCtrl', ["$scope", "$http", ($scope, $http) ->
  $http.get('/api/articles').success((response) ->
  	$scope.awesomeArticles = response.articles
  )
])

