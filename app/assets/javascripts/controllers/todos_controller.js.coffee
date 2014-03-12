'use strict';

angular.module('AngularTodo').controller 'TodosCtrl', ($scope, $routeParams, TaskList) ->
  $scope.init = () ->
    @task_lists_service = new TaskList(serverErrorHandler)
    $scope.task_lists = @task_lists_service.all()

  $scope.create_list = () ->
    @task_lists_service.create($scope.new_list, (task_list) ->
      $scope.task_lists.push(task_list)
      $scope.new_list = null
    )

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again.")