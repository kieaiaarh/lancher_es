require 'elasticsearch/extensions/test/cluster'
RSpec.configure do |config|
  config.before(:all, :elasticsearch) do
    Elasticsearch::Extensions::Test::Cluster.start port: 9250, command: '/usr/local/bin/elasticsearch', nodes: 1 unless Elasticsearch::Extensions::Test::Cluster.running?(on: 9250)
  end

  config.after(:all, :elasticsearch) do
    Elasticsearch::Extensions::Test::Cluster.stop if Elasticsearch::Extensions::Test::Cluster.running?(on: 9250)
  end
end
