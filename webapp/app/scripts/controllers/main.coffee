'use strict'

angular.module('app').controller('MainCtrl', ["$scope", "$http", ($scope, $http) ->
  $http.get('/api/articles').success((articles) ->
  	$scope.awesomeArticles = articles
  )
])

