NDS = NdsApi::Client.new(
  agency_key: ENV['NDS_API_AGENCY_KEY'] || 13_011,
  user: ENV['NDS_API_USERNAME'] || 'exygy',
  password: ENV['NDS_API_PASSWORD'] || 'testnaccrra',
  dev: ENV['NDS_API_DEV'] ? ENV['NDS_API_DEV'] == "true" : true,
  debug: ENV['NDS_API_DEBUG'] ? ENV['NDS_API_DEBUG'] == "true" : false
)
