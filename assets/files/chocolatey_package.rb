chocolatey_package 'name' do
  options       String
  package_name  String, Array # defaults to 'name' if not specified
  returns       Integer, Array # default value: [0]
  source        String
  timeout       String, Integer
  version       String, Array
  action        Symbol # defaults to :install if not specified
end
