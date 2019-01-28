EnvImagesController = ($scope, $modal, $timeout, $filter)  ->
  $ctrl = @

  @$onInit = () ->
    $ctrl.urls = _.values($ctrl.urls)

  @openCarousel = (image) ->
    $modal.open {
      templateUrl: '/assets/provider/env_images/carousel/carousel.html'
      controller: 'CarouselController'
      resolve: {
        urls: ->
           $ctrl.urls
        selected: ->
          image
        header: ->
          $filter('providerName')($ctrl.provider)
      }
    }

  return @

EnvImagesController.$inject = ['$scope', '$modal', '$timeout', '$filter']

angular
  .module('CCR')
  .component('envImages', {
    bindings: {
      urls: '<'
      provider: '<'
    }
    controller: EnvImagesController
    templateUrl: "provider/env_images/env_images.html"
  })
