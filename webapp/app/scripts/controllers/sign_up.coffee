'use strict'

angular.module('app').controller('SignUpCtrl', ["$scope", "$http", ($scope, $http) ->
	$scope.user = null

	$scope.signUp = () ->
		$http.post('/api/sign_up', $scope.user)
			.success((data) ->
				$scope.$broadcast('event:authenticated')
				$location.path('/')
			)
			.error((reason) -> $scope.user.errors = reason)
])