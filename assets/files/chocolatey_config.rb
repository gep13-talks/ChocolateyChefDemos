chocolatey_config 'name' do
  config_key  String # default value: 'name' unless specified
  value       String
  action      Symbol # defaults to :set if not specified
end
