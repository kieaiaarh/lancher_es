require 'elasticsearch/extensions/test/cluster'
#-------------------------------
# ex) lanched elasticsearch
#
# elasticsearch -D es.foreground=yes -D es.cluster.name=elasticsearch-test-apple-no-macbook-pro.local -D es.node.name=node-1 -D es.http.port=9250 -D es.path.data=/tmp/elasticsearch_test -D es.path.work=/tmp -D es.path.logs=/tmp/log/elasticsearch -D es.cluster.routing.allocation.disk.threshold_enabled=false -D es.network.host=localhost -D es.script.inline=true -D es.script.stored=true -D es.node.attr.testattr=test -D es.path.repo=/tmp -D es.repositories.url.allowed_urls=http://snapshot.test* -D es.logger.level=DEBUG -D es.gateway=local
# -----------------------------

RSpec.configure do |config|
  config.before(:all, :elasticsearch) do
    WebMock.disable_net_connect!(allow_localhost: true)
    Elasticsearch::Extensions::Test::Cluster.start port: 9250, network_host: 'localhost', es_params: '-D es.gateway=local' unless Elasticsearch::Extensions::Test::Cluster.running?(on: 9250)
  end

  config.after(:all, :elasticsearch) do
    Elasticsearch::Extensions::Test::Cluster.stop port: 9250, network_host: 'localhost', es_params: '-D es.gateway=local' if Elasticsearch::Extensions::Test::Cluster.running?(on: 9250)
  end
end
