'use strict';

angular.module('AngularTodo').factory 'Task', ($resource, $http) ->
  class TaskList
    constructor: (list_id, errorHandler) ->
      @service = $resource('/api/task_lists/:list_id/tasks/:id',
        { list_id: list_id, id: '@id' },
        { update: {method: 'PATCH'} }
      )

      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: ->
      @service.query((-> null), @errorHandler)

    create: (attrs, successHandler) ->
      new @service(task: attrs).$save ((list) -> successHandler(list)), @errorHandler