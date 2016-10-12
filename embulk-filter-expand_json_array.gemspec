
Gem::Specification.new do |spec|
  spec.name          = "embulk-filter-expand_json_array"
  spec.version       = "0.1.0"
  spec.authors       = ["Naoki AINOYA"]
  spec.summary       = "Expand Json Array filter plugin for Embulk"
  spec.description   = "Expand Json Array"
  spec.email         = ["ainonic@gmail.com"]
  spec.licenses      = ["MIT"]
  # TODO set this: spec.homepage      = "https://github.com/ainonic/embulk-filter-expand_json_array"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'jsonpath', ['>= 0.5.8']

  spec.add_development_dependency 'embulk', ['>= 0.8.13']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
