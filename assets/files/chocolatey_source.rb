chocolatey_source 'name' do
  bypass_proxy  true, false # default value: false
  priority      Integer # default value: 0
  source        String
  source_name   String # default value: 'name' unless specified
  action        Symbol # defaults to :add if not specified
end
