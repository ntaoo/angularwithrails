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
    resolve: { checkCurrentUser: ["Authentication", (Authentication) -> Authentication.checkCurrentUser()] }
  .otherwise
    redirectTo: '/'
])

app.config(["$httpProvider", ($httpProvider) ->
  interceptor = ['$rootScope', '$location', '$q', ($rootScope, $location, $q) ->
    success = (response) -> response
    error = (response) ->
      if response.status == 401
        console.log ' catch 401'
        $rootScope.$broadcast('event:signInRequired')
        $q.reject(response)
      else if response.status == 422
        console.log 'catch 422'
        $q.reject(response)
      else
        $q.reject(response)

    return (promise) -> promise.then(success, error)
  ]
  $httpProvider.responseInterceptors.push(interceptor)
])


app.service('Authentication', ["$rootScope", "$http", "$q", "$location", "currentUser", ($rootScope, $http, $q, $location, currentUser) ->

  signUp: (email, password) ->
    deferred = $q.defer()
    $http.post('/api/sign_up', { sign_up: { email: email, password: password } })
      .success((data) ->
          console.log 'signed up and signed in'
          currentUser.set(data.currentUser)
          $rootScope.$broadcast('event:signedIn')
          deferred.resolve()
        )
      .error((data, status) ->
          if status == 422
            console.log 'status code: 422'
            deferred.reject(data, status)
          else
            deferred.reject(data, status)
      )
    return deferred.promise


  signIn: (email, password)  ->
    deferred = $q.defer()
    $http.post('/api/sign_in', { session: { email: email, password: password } })
      .success((data) ->
        console.log 'signed in'
        currentUser.set(data.currentUser)
        $rootScope.$broadcast('event:signedIn')
        deferred.resolve()
      )
      .error((data, status) ->
        if status == 422
          console.log 'status code: 422'
          deferred.reject(data, status)
        else
          deferred.reject(data, status)
      )
    return deferred.promise


  checkCurrentUser: () ->
    if !(currentUser.isExisting())
      $rootScope.$broadcast('event:signInRequired')

  clearCurrentUser: () ->
    currentUser.clear()
])

app.service('currentUser', ["$http", "$q", ($http, $q) ->
  id = null
  email = null

  _clear = () ->
    id = null
    email = null

  isExisting: () -> id != null && email != null

  signOut: () ->
    deferred = $q.defer()
    $http.delete('/api/sign_out')
    .success(() ->
      _clear()
      deferred.resolve()
    )
    .error((data, status) ->
      if status == 422
        console.log 'status code: 422'
        deferred.reject(data, status)
      else
        deferred.reject(data, status)
    )


  set: (user) ->
    id = user.id
    email = user.email

  clear: () -> _clear()

])

app.run(["$rootScope", "$http", "$location", "Authentication", ($rootScope, $http, $location, Authentication) ->
  $rootScope.$on('event:signInRequired', (_) ->
    Authentication.clearCurrentUser()
    $location.path('/sign_in')
  )
])

