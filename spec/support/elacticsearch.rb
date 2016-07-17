require 'elasticsearch/extensions/test/cluster'

RSpec.configure do |config|

  WebMock.allow_net_connect!
  config.before(:all, :elasticsearch) do
    Elasticsearch::Extensions::Test::Cluster.start port: 9250, network_host: 'localhost' unless Elasticsearch::Extensions::Test::Cluster.running?(on: 9250)
  end

  config.after(:all, :elasticsearch) do
    Elasticsearch::Extensions::Test::Cluster.stop port: 9250 if Elasticsearch::Extensions::Test::Cluster.running?(on: 9250)
  end

end
