ResultMapController = ($scope, ResultsService, EmailCollectorService) ->
  $ctrl = @

  $scope.filters = ResultsService.filters
  $scope.limitPinsOnMap = EmailCollectorService.status.shouldPromptEmailCta ? 5 : 15

  $scope.$on 'search-service:updated', (event, service) ->
    $scope.filters = service.filters

ResultMapController.$inject = ['$scope', 'ResultsService', 'EmailCollectorService']

angular
  .module('CCR')
  .component('resultMap', {
    bindings:
      data: '<'
      showSearchOnDrag: '<'
    controller: ResultMapController
    templateUrl: "results/components/result_map/result_map.html"
  })
