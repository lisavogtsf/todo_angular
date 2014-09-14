# app.js.coffee

# set up angular module and dependencies
TodoApp = angular.module("TodoApp", ["ngRoute", "templates"])

# angular router
TodoApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
	$routeProvider
		.when "/",
			templateUrl: "index.html",
			controller: "TaskCtrl"
		# show/read route
		.when '/tasks/:id',
			templateUrl: "show.html"
			controller: "TaskCtrl"
	.otherwise
		redirectTo: "/"

	$locationProvider.html5Mode(true).hashPrefix("#")
]

# angular task controller
TodoApp.controller "TaskCtrl", ["$scope", "$http", ($scope, $http) ->

	$scope.tasks = [{
		 desc: "laundry"
	}, {
		desc: "take out trash"
	}]

	# READ/SHOW
	$scope.getTasks = ->
	# make a GET request to /tasks.json
		$http.get("/tasks.json").success (data) ->
			$scope.tasks = data

	# this function seemed to make the task list blink and disappear
	# $scope.getTasks()

	# CREATE/NEW
	addTask = ->
		# worry about injection? validation?
		# internal api call to rails controller, using json format
		# rails controller creates new task in database, returns object as success
		$http.post("/tasks.json", $scope.newTask).success (data) ->
			# clear out the add task form
			$scope.newTask ={}
			# add new task database object to tasks array
			#console.log(task)
			$scope.tasks.push(task)
			#console.log(task)
			#console.log(tasks)



	# UPDATE/EDIT

	# DESTROY/DELETE


]

#CSRF
TodoApp.config ["$httpProvider", ($httpProvider) ->
	$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=crsf-token]').attr('content')
]