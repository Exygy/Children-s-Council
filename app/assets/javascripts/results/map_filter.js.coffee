ToMarkers = ($rootScope) ->
  (providers) ->
    if providers
      for provider, index in providers
        providers[index]['isIconVisibleOnClick'] = true
        providers[index]['closeClick'] = 'none'
        providers[index]['marker_icon'] = 'icon_url_should_vary_based_on_provider_type'

        # this to prevent the digest loop to go crazy
        unless providers[index]['coords']
          providers[index]['coords'] = {
            latitude: provider.latitude,
            longitude: provider.longitude
          }

        care_type_id = providers[index].care_type_id
        if $rootScope.data['care_types'][care_type_id]
          if $rootScope.data['care_types'][care_type_id].facility
            providers[index]['gmap_icon'] = "fa-building"
            providers[index]['gmap_icon_title'] = "Child Care Center"
            providers[index]['display_address'] = provider.address_1
            providers[index]['display_address'] += ' ' + provider.address_2 if provider.address_2
          else
            providers[index]['gmap_icon'] = "fa-home"
            providers[index]['gmap_icon_title'] = "Family Child Care"
            providers[index]['display_address'] = provider.cross_street_1 + ' & ' + provider.cross_street_2

    return providers

ToMarkers.$inject = ['$rootScope']
angular.module('CCR').filter('toMarkers', ToMarkers)
