'use strict';

angular.module('AngularTodo').factory 'TaskList', ($resource, $http) ->
  class TaskList
    constructor: (errorHandler) ->
      @service = $resource('api/task_lists/:id',
        {id: '@id'},
        {update: {method: 'PATCH'}}
      )

      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: ->
      @service.query((-> null), @errorHandler)

    create: (attrs, successHandler) ->
      new @service(task_list: attrs).$save ((list) -> successHandler(list)), @errorHandler