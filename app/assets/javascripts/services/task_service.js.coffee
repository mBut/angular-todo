'use strict';

angular.module('AngularTodo').factory 'Task', ($resource, $http) ->
  class TaskList
    constructor: (list_id, errorHandler) ->
      @service = $resource('/api/task_lists/:list_id/tasks/:id',
        { list_id: list_id, id: '@id' },
        { 
          update: {method: 'PATCH'}
          getPage:
            params:
              page: '@page'
            isArray: true
        }
      )

      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: ->
      @service.query((-> null), @errorHandler)

    getPage: (page, successHandler) ->
      @service.getPage({page: page}, successHandler, @errorHandler)

    create: (attrs, successHandler) ->
      new @service(task: attrs).$save ((list) -> successHandler(list)), @errorHandler

    update: (task, attrs) ->
      new @service(task: attrs).$update {id: task.id}, (-> null), @errorHandler

    delete: (task) ->
      new @service().$delete {id: task.id}, (-> null), @errorHandler