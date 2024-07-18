default['common']['environment'] = 'kitchen'

default['datadog']['api_key'] = ''
default['datadog']['application_key'] = ''

default['datadog']['agent_major_version'] = 7
default['datadog']['agent_version'] = '7.49.1'
default['datadog']['chef_handler_version'] = '0.15.0'
=begin
default['datadog']['windows_agent_url'] = ::File.join(
  node['common']['artifactory'],
  'datadog-stable'
) + '/' # requires the / at the end
=end

# APM/Trace config
default['datadog']['enable_trace_agent'] = true
default['hps-datadog']['trace']['service-blacklist'] = %w(powershell powershell-command powershell-http-client choco wsmprovhost wsmprovhost-command servermanager shimgen taskhostw) # services to filter out so they aren't sent to DD apm 
default['datadog']['extra_config']['apm_config'] = {
  'ignore_resources' => '["choco","powershell","powershell-http-client","servermanager","shimgen","taskhostw","wsmprovhost"]'
}
default['datadog']['extra_config']['apm_opts'] = {
  'DD_APM_COMPUTE_STATS_BY_SPAN_KIND' => 'true',
  'DD_APM_PEER_TAGS_AGGREGATION' => 'true',
  'DD_APM_PEER_TAGS' => '["_dd.base_service","amqp.destination","amqp.exchange","amqp.queue","aws.queue.name","aws.s3.bucket","bucketname","cassandra.keyspace","db.cassandra.contact.points","db.couchbase.seed.nodes","db.hostname","db.instance","db.name","db.namespace","db.system","grpc.host","hostname","http.host","http.server_name","messaging.destination","messaging.destination.name","messaging.kafka.bootstrap.servers","messaging.rabbitmq.exchange","messaging.system","mongodb.db","msmq.queue.path","net.peer.name","network.destination.name","peer.hostname","peer.service","queuename","rpc.service","rpc.system","server.address","streamname","tablename","topicname"]',
}
