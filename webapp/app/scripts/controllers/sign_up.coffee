'use strict'

angular.module('app').controller('SignUpCtrl', ["$scope", "$http", "$location", ($scope, $http, $location) ->
	$scope.user = null

	$scope.signUp = () ->
		$http.post('/api/sign_up', { sign_up: $scope.user })
			.success((data) ->
        console.log 'success'
        console.log data.info
				$scope.$broadcast('event:authenticated')
				$location.path('/')
			)
			.error((reason) ->
        console.log 'error'
        $scope.user.errors = reason
      )
])