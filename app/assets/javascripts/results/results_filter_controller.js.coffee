ResultsFilterController = ($scope, $modal, ResultsService) ->
  $scope.filters = ResultsService.filters
  $scope.settings = ResultsService.settings
  $scope.parent = ResultsService.parent
  $scope.showMoreFilters = false

  $scope.openResultFiltersModal = () ->
    $modal.open {
      templateUrl: 'results/result_filters_modal.html'
      controller: 'ResultFiltersModalController'
    }

  $scope.openChildModal = (child_id) ->
    $modal.open {
      templateUrl: 'results/child_filter_modal.html'
      controller: 'ChildModalController'
      resolve:
         childId: ->
           child_id
    }

ResultsFilterController.$inject = ['$scope', '$modal', 'ResultsService']
angular.module('CCR').controller('ResultsFilterController', ResultsFilterController)