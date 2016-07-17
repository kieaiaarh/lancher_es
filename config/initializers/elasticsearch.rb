erb    = Rails.root.join('config/elasticsearch.yml').read
yaml   = ERB.new(erb).result
config = YAML.load(yaml)

if (option = config[Rails.env])
  Elasticsearch::Model.client = Elasticsearch::Client.new(ActiveSupport::HashWithIndifferentAccess.new(option))
else
  warn 'No Elasticsearch configuration was found. Using default client.'
end
