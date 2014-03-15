angular.module('AngularTodo').filter 'getById', ->
  (input, id) ->
    for el in input
      if parseInt(el.id) == parseInt(id)
        return el;