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

	$scope.tasks = []
	$scope.editTask = false

	# READ/SHOW
	$scope.getTasks = ->
	# make a GET request to /tasks.json
		$http.get("/tasks.json").success (data) ->
			# console.log("data from http get call, ", data)
			$scope.tasks = data

	$scope.getTasks()

	# CREATE/NEW -- non-functional
	$scope.addTask = ->
		console.log("newTask parameters, ", $scope.newTask)
		# worry about injection? validation?
		# internal api call to rails controller, using json format
		# rails controller creates new task in database, returns object as success
		$http.post("/tasks.json", $scope.newTask).success (data) ->
			# clear out the add task form
			$scope.newTask ={}
			# add new task database object to tasks array
			# console.log(data)
			$scope.tasks.push(data)
			#console.log(task)
			# console.log(tasks)

	# UPDATE/EDIT
	$scope.startEditTask = (task) ->
		#$scope.editTask = true
		task.editTask = true

	$scope.endEditTask = ->
		#$scope.editTask = false
		task.editTask = false

	$scope.editTask = (task) ->
		#not sure
		#$scope.editTask = false
		task.editTask = false

	#marked
	$scope.completedTask = (task) ->
		task.completed = true

	#add back
	$scope.repeatTask = (task) ->
		task.completed = false

	# DESTROY/DELETE
	$scope.deleteTask = (task) ->
		conf = confirm "are you sure?"
		if conf
			console.log("after confirm delete task, ", task)
			$http.delete("/tasks/#{task.id}.json").success (data) ->
				console.log("task, ", task)
				console.log(data)
				$scope.tasks.splice($scope.tasks.indexOf(task), 1)


]

#CSRF
TodoApp.config ["$httpProvider", ($httpProvider) ->
	$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=crsf-token]').attr('content')
]