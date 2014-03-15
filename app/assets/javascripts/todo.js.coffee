'use strict';

angular.module('AngularTodo', ['ngResource', 'ngRoute','ui.bootstrap'])
  .config ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/task_lists',
        templateUrl: '/templates/todos',
        controller: 'TodosCtrl'
      .when '/task_lists/:listId',
        templateUrl: '/templates/todos',
        controller: 'TodosCtrl'
      .otherwise
        redirectTo: '/task_lists'

    $locationProvider.html5Mode(true);

$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])