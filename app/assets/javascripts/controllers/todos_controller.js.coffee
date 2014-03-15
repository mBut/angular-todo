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

  $scope.updateTask = (task) ->
    @tasks_service.update task,
      completed_flag: task.completed_flag
      due_date: task.due_date

  $scope.deleteTask = (task) ->
    result = confirm "Are you sure you want to remove this task"

    if result
      @tasks_service.delete(task)
      $scope.tasks.splice($scope.tasks.indexOf(task), 1)

  $scope.openDatapicker = (task, $event) ->
    $event.preventDefault()
    $event.stopPropagation()

    task.show_datapicker = true

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again.")