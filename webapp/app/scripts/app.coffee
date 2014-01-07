'use strict'

app = angular.module('app', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])

app.config(["$locationProvider", ($locationProvider) ->
  $locationProvider.html5Mode(true)
])

app.config(["$routeProvider", ($routeProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'views/main.html'
    controller: 'MainCtrl'
  .when '/sign_in',
    templateUrl: 'views/sign_in.html'
    controller: 'SignInCtrl'
  .when '/sign_up',
    templateUrl: 'views/sign_up.html'
    controller: 'SignUpCtrl'
  .when '/articles',
    templateUrl: 'views/articles.html'
    controller: 'ArticlesCtrl',
    resolve: { checkCurrentUser: (Authentication) -> Authentication.checkCurrentUser() }
  .otherwise
    redirectTo: '/'
])

app.config(["$httpProvider", ($httpProvider) ->
  interceptor = ['$rootScope', '$location', '$q', ($scope, $location, $q) ->
    success = (response) -> response
    error = (response) ->
      if response.status == 401
        d = $q.defer()
        $scope.$broadcast('event:unauthorized')
        return d.promise
      return $q.reject(response)

    return (promise) -> promise.then(success, error)
  ]
  $httpProvider.responseInterceptors.push(interceptor)
])


app.service('Authentication', ["$rootScope", "$http", "$q", "$location", "currentUser", ($rootScope, $http, $q, $location, currentUser) ->

  signIn: (email, password)  ->
    $http.post('/api/sign_in', { session: { email: email, password: password } })
      .success((data) ->
          console.log 'signed in'
          currentUser.set(data.user)
          $rootScope.$broadcast('event:authenticated')
          $location.path('/')
      )
      .error((reason) ->
          console.log 'error'
          console.log reason
      )


  checkCurrentUser: () ->
    if !(currentUser.isExisting())
      $rootScope.$broadcast('event:unauthorized')

  clearCurrentUser: () ->
    currentUser.clear()
])

app.service('currentUser', ["$http", ($http) ->
  id = null
  email = null

  _clear = () ->
    id = null
    email = null

  isExisting: () -> id != null && email != null

  signOut: () ->
    $http.delete('/api/sign_out').success((_) ->
      console.log 'sign out'
      _clear()
    )

  set: (user) ->
    id = user.id
    email = user.email

  clear: () -> _clear()

])

app.run(["$rootScope", "$http", "$location", "Authentication", ($rootScope, $http, $location, Authentication) ->
  $rootScope.$on('event:unauthorized', (_) ->
    Authentication.clearCurrentUser()
    $location.path('/sign_in')
  )
])

