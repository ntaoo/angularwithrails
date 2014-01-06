'use strict'

angular.module('app').controller('ArticlesCtrl', ["$scope", "$http", ($scope, $http) ->
  $http.get('/api/articles').success((response) ->
    $scope.awesomeArticles = response.articles
  )
])