DataService = ($rootScope, HttpService) ->
  @data = {
    totalProviders: 0
    providersPerPage: 15
    providers: []
    is_loading: false
  }

  @settings = {
    location_type: 'near_address'
  }

  @parent = {
    full_name: ''
    email: ''
    phone: ''
    home_zip_code: ''
    near_address: ''
    agree: false
    subscribe: false
    found_option_id: null
    parents_care_reasons_attributes: ['']
    parents_care_types_attributes: []
    children_attributes: [
      {
        age_months: 30,
        schedule_day_ids: [2,3,4,5,6]
        children_schedule_days_attributes: []
        schedule_week_ids: [1]
        children_schedule_weeks_attributes: []
        schedule_year_id: 1
        selected: true
      }
    ]
  }

  @filters = {
    near_address: null
    co_op: null
    meals_included: null
    potty_training: null
    language_ids: ['']
    program_ids: []
    subsidy_ids: []
    language_immersion_ids: ['']
    religion_ids: ['']
    care_approach_ids: ['']
    neighborhood_ids: ['']
    zip_code_ids: ['']
    care_type_ids: []
  }

  @current_page = 1

  @getLocation = ->
    if @settings.location_type == 'near_address'
      if @filters.near_address and @filters.near_address.indexOf(', San Francisco, CA') == -1
        @filters.near_address + ', San Francisco, CA'
      else
        @filters.near_address
    else
      @filters[@settings.location_type]

  @buildParent = ->
    @parent.parents_care_types_attributes = @filters.care_type_ids.map (care_type_id) ->
      { 'care_type_id': care_type_id }

  @buildChildren = ->
    for child, index in @parent.children_attributes
      @parent.children_attributes[index].children_schedule_days_attributes = []
      if child.schedule_day_ids
        for schedule_day_id in child.schedule_day_ids
          @parent.children_attributes[index].children_schedule_days_attributes.push { schedule_day_id: schedule_day_id }

      @parent.children_attributes[index].children_schedule_weeks_attributes = []
      if child.schedule_week_ids
        for schedule_week_id in child.schedule_week_ids
          @parent.children_attributes[index].children_schedule_weeks_attributes.push { schedule_week_id: schedule_week_id }

  @concatProgramsIds = ->
    program_ids = []
    if @filters.language_immersion_ids.length and @filters.language_immersion_ids[0] != ''
      program_ids = program_ids.concat @filters.language_immersion_ids
    if @filters.religion_ids.length and @filters.religion_ids[0] != ''
      program_ids = program_ids.concat @filters.religion_ids
    if @filters.care_approach_ids.length and @filters.care_approach_ids[0] != ''
      program_ids = program_ids.concat @filters.care_approach_ids
    program_ids

  @getSearchParams = ->
    @buildParent()
    @buildChildren()
    search_params = angular.copy @filters

    # those params should be children specific when the feature is built
    search_params.ages = [@parent.children_attributes[0].age_months]
    search_params.schedule_year_ids = [@parent.children_attributes[0].schedule_year_id]
    search_params.schedule_week_ids = @parent.children_attributes[0].schedule_week_ids
    search_params.schedule_day_ids = @parent.children_attributes[0].schedule_day_ids

    search_params.program_ids = @concatProgramsIds()
    delete search_params.language_immersion_ids
    delete search_params.religion_ids
    delete search_params.care_approach_ids
    delete search_params.near_address
    delete search_params.zip_code_ids
    delete search_params.neighborhood_ids
    search_params[@settings.location_type] = @getLocation()
    search_params

  @cleanEmptyParams = (params) ->
    deepFilter params, (value, key) ->
      # Filter out empty values and arrays
      if !value? or (Array.isArray(value) and (value.length == 0 or value[0] == '')) then false else true

  @getCleanedParent = ->
    parent = angular.copy @parent
    delete parent.care_type_ids
    delete parent.agree
    for child, index in parent.children_attributes
      delete parent.children_attributes[index].schedule_day_ids
      delete parent.children_attributes[index].schedule_week_ids
      delete parent.children_attributes[index].selected
    parent

  @queryParams = ->
    @cleanEmptyParams {
      page: @current_page
      per_page: @data.providersPerPage
      providers: @getSearchParams()
      parent: @getCleanedParent()
    }

  @httpParams = ->
    {
      method: 'POST'
      url: '/api/providers'
      data: @queryParams()
    }

  @performSearch = (callback) =>
    that = @
    that.data.providers = []
    that.data.is_loading = true
    @serverRequest (response) ->
      if response.data
        that.data.providers = response.data.content
        that.data.totalProviders = response.data.totalElements
        that.data.current_page = that.data.number
      callback(response.data) if callback
      that.data.is_loading = false

  @serverRequest = (callback) ->
    HttpService.http @httpParams(), callback

  @resetData = ->
    @data.providers = []
    @data.totalProviders = 0

  @

DataService.$inject = ['$rootScope', 'HttpService']
angular.module('CCR').service('DataService', DataService)
