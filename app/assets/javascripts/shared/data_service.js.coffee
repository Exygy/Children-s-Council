DataService = ($http) ->
  @data = {
    totalProviders: 0,
    providersPerPage: 25,
    providers: [],
  }

  @parent = {
    firstName: ''
    lastName: ''
    email: ''
    phone: ''
  }

  @search_params = {
    near_address: ''
  }

  @current_page = 1

  @queryParams = ->
    {
      page: @current_page,
      per_page: @providersPerPage,
      providers: @search_params,
      parent: @parent,
    }

  @resetData = ->
    @data.providers = []
    @data.totalProviders = 0

  @performSearch = (callback) =>
    that = @    
    @serverRequest (response) ->
      that.data.providers = response.data.providers
      that.data.totalProviders = response.data.total
      callback() if callback

  @serverRequest = (callback) ->
    $http {
      method: 'POST',
      url: '/api/providers',
      data: @queryParams()
    }
    .then (response) ->
      # this callback will be called asynchronously
      # when the response is available
      callback(response) if callback
  @

DataService.$inject = ['$http']
angular.module('CCR').service('DataService', DataService)
