'use strict';

angular.module('AngularTodo').controller 'TodosCtrl', ($scope,$location,$routeParams,$filter,TaskList,Task) ->
  $scope.init = () ->
    @task_lists_service = new TaskList(serverErrorHandler)
    $scope.task_lists = @task_lists_service.all()

    $scope.initTasks()

  $scope.initTasks = ->
    if $routeParams.listId
      @tasks_service = new Task($routeParams.listId, serverErrorHandler)
      $scope.tasks = @tasks_service.all()

  $scope.currentList = ->
    $filter('getById')($scope.task_lists, $routeParams.listId) if $routeParams.listId

  $scope.showTaskForm = ->
    $routeParams.listId?

  $scope.createList = () ->
    @task_lists_service.create($scope.new_list, (task_list) ->
      $scope.task_lists.push(task_list)
      $scope.new_list = null
    )

  $scope.createTask = () ->
    @tasks_service.create($scope.new_task, (task) ->
      $scope.tasks.push(task)
      $scope.new_task = null
    )

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again.")