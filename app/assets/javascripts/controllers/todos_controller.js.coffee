'use strict';

angular.module('AngularTodo').controller 'TodosCtrl', ($scope,$location,$routeParams,$filter,TaskList,Task) ->
  $scope.init = () ->
    @task_lists_service = new TaskList(serverErrorHandler)
    $scope.task_lists = @task_lists_service.all()

    $scope.initTasks()

  $scope.initTasks = ->
    if $routeParams.listId
      @tasks_service = new Task($routeParams.listId, serverErrorHandler)
      $scope.all_tasks = @tasks_service.all()

  $scope.tasks_order_by = "note"
  $scope.tasks_active_filter = "all"

  $scope.currentList = ->
    $filter('getById')($scope.task_lists, $routeParams.listId) if $routeParams.listId

  $scope.showTaskForm = ->
    $routeParams.listId?

  $scope.createList = () ->
    if $scope.new_list && $scope.new_list.name != undefined && $scope.new_list.name != ''
      @task_lists_service.create($scope.new_list, (task_list) ->
        $scope.task_lists.push(task_list)
        $scope.new_list = null
      )

  $scope.createTask = () ->
    if $scope.new_task && $scope.new_task.note != undefined && $scope.new_task.note != ''
      @tasks_service.create($scope.new_task, (task) ->
        $scope.all_tasks.push(task)
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
      $scope.all_tasks.splice($scope.all_tasks.indexOf(task), 1)

  $scope.moveTask = ($data, task_list) ->
    # As $data isn't instance of task service, then corresponded task should be found
    task = $filter('getById')($scope.all_tasks, $data.id)

    if task.task_list_id != task_list.id
      result = confirm "Move task: "+ task.note + "\nTo list: " + task_list.name + " ?"

      if result
        @tasks_service.update task,
          task_list_id: task_list.id

        $scope.all_tasks.splice($scope.all_tasks.indexOf(task), 1)

  $scope.searchTasks = ->
    $scope.tasks_active_filter = "search"

  $scope.filteredTasks = ->
    switch $scope.tasks_active_filter
      when 'active' then $filter('getByCompletedFlag')($scope.all_tasks, false)
      when 'completed' then $filter('getByCompletedFlag')($scope.all_tasks, true)
      when 'search' then $filter('getByNoteText')($scope.all_tasks, $scope.search)
      else $scope.all_tasks

  $scope.tasksPresent = ->
    $routeParams.listId? && $scope.all_tasks.length > 0

  $scope.setActiveFilter = (filter) ->
    # Clear search field and show all tasks
    $scope.search = null
    $scope.tasks_active_filter = filter

  $scope.activeTasks = ->
    if $routeParams.listId? then $filter('getByCompletedFlag')($scope.all_tasks, false) else {}

  $scope.completedTasks = ->
    if $routeParams.listId? then $filter('getByCompletedFlag')($scope.all_tasks, true) else {}

  # In the current infinite scroll implementation loadMoreTasks function calls when user reached bottom of the page
  # loadMoreTasks sends request to server and merge responce tasks with existing.
  # If tasks count in the response is less than defined in backend page size, then we disable the infinite scroll dirictive
  $scope.next_page = 2
  $scope.no_next_page = false

  $scope.loadMoreTasks = ->
    if $routeParams.listId?
      @tasks_service.getPage $scope.next_page, (result) ->
        $scope.all_tasks = $scope.all_tasks.concat(result)

        if result.length < 20
          $scope.no_next_page = true
        else
          $scope.next_page++

  $scope.openDatapicker = (task, $event) ->
    $event.preventDefault()
    $event.stopPropagation()

    task.show_datapicker = true

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again.")