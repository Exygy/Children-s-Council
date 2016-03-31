module Api
  class ProvidersController < ApiController
    def index
      # Include associated provider models where we need information for display in the results list
      # (prevents individual join queries for each provider)
      providers = Provider
      providers = providers.search_by_zip_code_ids(provider_param_zip_code_ids) if provider_param_zip_code_ids
      providers = providers.search_by_neighborhood_ids(provider_param_neighborhood_ids) if provider_param_neighborhood_ids
      providers = providers.near(provider_param_near_address, 20) if provider_param_near_address
      providers = providers.search_by_ages(provider_param_ages) if provider_param_ages
      providers = providers.search_by_days_and_hours(provider_param_open_days) if provider_param_open_days
      providers = providers.search_by_language_ids(provider_param_language_ids) if provider_param_languages_ids
      providers = providers.search_by_schedule_year_ids(provider_param_schedule_year_ids) if provider_param_schedule_year_ids
      providers = providers.search_by_schedule_week_ids(provider_param_schedule_week_ids) if provider_param_schedule_week_ids
      providers = providers.search_by_schedule_day_ids(provider_param_schedule_day_ids) if provider_param_schedule_day_ids
      providers = providers.search_by_care_type_ids(provider_param_care_type_ids) if provider_param_care_type_ids

      # rate: shit show?
      # financial_assistance: [1,2,3] foreign_key
      # child_care_philisophie: [1,2,3] foreign_key
      # special_needs: [1,2,3] - foreign_key
      # meals_included: true - many to many but mainly is there any entry

      # randomize result order unless searching by near by address
      if provider_param_near_address
        providers = providers.preload(:care_type, :licenses, :schedule_hours, :subsidies)
      else
        Provider.connection.execute "SELECT setseed(#{@current_parent.random_seed})"
        providers = providers.eager_load(:care_type, :licenses, :schedule_hours, :subsidies).select(['*', 'random()']).order('random()')
      end

      render json: {
        total: providers.size,
        providers: providers.page(params[:page]).per(params[:per_page]),
      }, status: 200
    end

    def show
      provider = Provider.eager_load(
        :care_type,
        :languages,
        :licenses,
        :meals,
        :programs,
        :schedule_days,
        :schedule_hours,
        :schedule_weeks,
        :subsidies,
      ).find(params[:id])
      render json: ProviderSerializer.new(provider), status: 200
    end

    private

    def provider_params
      params.require(:providers).permit(
        :near_address,
        ages: [],
        care_type_ids: [],
        language_ids: [],
        neighborhood_ids: [],
        open_days: [],
        schedule_day_ids: [],
        schedule_week_ids: [],
        schedule_year_ids: [],
        zip_code_ids: [],
      )
    end

    def method_missing(method_sym, *arguments, &block)
      method_name_prefix = 'provider_param_'
      if method_sym[0..method_name_prefix.length - 1] == method_name_prefix
        param = method_sym[method_name_prefix.length..method_sym.length]
        !provider_params[param.to_sym].blank? ? provider_params[param.to_sym] : false
      else
        super
      end
    end
  end
end
