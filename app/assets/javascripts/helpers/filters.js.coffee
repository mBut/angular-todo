angular.module('AngularTodo').filter 'getById', ->
  (input, id) ->
    for el in input
      if parseInt(el.id) == parseInt(id)
        return el;

angular.module('AngularTodo').filter 'getByCompletedFlag', ->
  (input, bool) ->
    result = []
    for el in input
      if el.completed_flag == bool
        result.push(el)

    result

angular.module('AngularTodo').filter 'getByNoteText', ->
  (input, text) ->
    result = []
    for el in input
      regex = new RegExp(text, "i");
      if el.note.match(regex)
        result.push(el)

    result