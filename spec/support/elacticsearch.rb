require 'elasticsearch/extensions/test/cluster'
#-------------------------------
# ex) lanched elasticsearch
#
# elasticsearch -Des.foreground=yes -Des.cluster.name=elasticsearch-test-apple-no-macbook-pro.local -Des.node.name=node-1 -Des.http.port=9250 -Des.path.data=/tmp/elasticsearch_test -Des.path.work=/tmp -Des.path.logs=/tmp/log/elasticsearch -Des.cluster.routing.allocation.disk.threshold_enabled=false -Des.network.host=localhost -Des.script.inline=true -Des.script.stored=true -Des.node.attr.testattr=test -Des.path.repo=/tmp -Des.repositories.url.allowed_urls=http://snapshot.test* -Des.logger.level=DEBUG -Des.gateway=local
# -----------------------------

RSpec.configure do |config|
  config.before(:all, :elasticsearch) do
    WebMock.disable_net_connect!(allow_localhost: true)
    Elasticsearch::Extensions::Test::Cluster.start port: 9250, network_host: 'localhost', es_params: '-Des.gateway=local' unless Elasticsearch::Extensions::Test::Cluster.running?(on: 9250)
  end

  config.after(:all, :elasticsearch) do
    Elasticsearch::Extensions::Test::Cluster.stop port: 9250, network_host: 'localhost', es_params: '-Des.gateway=local' if Elasticsearch::Extensions::Test::Cluster.running?(on: 9250)
  end
end
