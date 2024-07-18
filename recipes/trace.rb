package 'Datadog .NET Tracer 64-bit' do
  source 'https://github.com/DataDog/dd-trace-dotnet/releases/download/v2.52.0/datadog-dotnet-apm-2.52.0-x64.msi'
  checksum 'ebc4d9ad6464b4dbfd0ffba74b8bf4f46087b097b55b15d1c7d43a9557b8a5d7'
  version '2.52.0'
  action :install
end

#https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/dotnet-framework/?tab=windows#configuring-process-environment-variables
# Environment variables
dd_env_variables = {
  'COR_ENABLE_PROFILING': '1', # enable profiling of .net fw
  'CORECLR_ENABLE_PROFILING': '1', # enable profiling of .net core
  'DD_APPSEC_ENABLED': 'true', # enable Application Security Management (ASM)
  'DD_IAST_ENABLED': 'true', # only enable IAST scanning in dev environments
  'DD_LOGS_INJECTION': 'true', # injects identifiers for logs into apm events for correlation with dd logs. requires tracing library
  'DD_PROFILING_ENABLED': 'true', # enables the .net profiler
  'DD_RUNTIME_METRICS_ENABLED': 'true', # sends runtime metrics to DD
  'DD_TRACE_DEBUG': 'false', # By default, this should be set to false. In order to debug tracing, set this to true, and logs will appear here: C:\ProgramData\Datadog .NET Tracer\logs
  'DD_TRACE_ENABLED': 'true', # sends spans to DD agent
  'DD_TRACE_EXEC_ENVIRONMENT_FILTER': node['hps-datadog']['trace']['service-blacklist'].join(','), # filters out services so they won't show up in DD's service catalog.
  'DD_TRACE_REMOVE_INTEGRATION_SERVICE_NAMES_ENABLED': 'true'
}
dd_env_variables[:DD_ENV] = node['common']['environment'] unless node['common']['environment'].nil? # set environment if it's set, else leave it unset.

dd_env_variables.each_pair do |key, value|
  windows_env key do
    value value
    notifies :restart, 'service[datadog-agent]', :delayed if node['datadog']['agent_start']
  end
end

=begin
windows_service 'datadog-trace-agent' do
  action [:enable, :start]
  only_if { ::Win32::Service.exists?('datadog-trace-agent') }
end
=end