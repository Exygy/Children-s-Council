SearchService = ($http, $cookies, CC_COOKIE, DataService) ->
  angular.extend SearchService.prototype, DataService

  @deleteApiKey = ->
    $cookies.remove CC_COOKIE

  @postSearch = (callback) ->
    # reset API KEY == make sure parent are authenticated
    @deleteApiKey()
    @resetData()
    @current_page = 1
    @performSearch callback

  @

SearchService.$inject = ['$http', '$cookies', 'CC_COOKIE', 'DataService']
angular.module('CCR').service('SearchService', SearchService)
