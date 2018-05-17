LocationController = (LocationService) ->
  $ctrl = @

  @$onInit = () ->
    $ctrl.provider = LocationService.mapify($ctrl.provider)
    return

  return @

LocationController.$inject = ['LocationService']

angular
  .module('CCR')
  .component('location', {
    bindings:
      provider: '<'
    controller: LocationController
    templateUrl: "/assets/provider/location/location.html"
  })
