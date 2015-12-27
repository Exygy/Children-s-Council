# Transform incoming json camelCase parameters into standard ruby snake_case
Rails.application.config.middleware.swap(
  ::ActionDispatch::ParamsParser, ::ActionDispatch::ParamsParser,
  ::Mime::JSON => proc do |raw_post|
    # Borrowed from action_dispatch/middleware/params_parser.rb except for
    # data.deep_transform_keys!(&:underscore) :
    data = ::ActiveSupport::JSON.decode(raw_post)
    data = { _json: data } unless data.is_a?(::Hash)
    data = ::ActionDispatch::Request::Utils.deep_munge(data)

    # Transform camelCase param keys to snake_case:
    data.deep_transform_keys!(&:underscore)

    data.with_indifferent_access
  end
)
