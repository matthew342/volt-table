# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'volt/table/version'

Gem::Specification.new do |spec|
  spec.name          = "volt-table"
  spec.version       = Volt::Table::VERSION
  spec.authors       = ["Matt Hale"]
  spec.email         = ["matt.hale.0@gmail.com"]
  spec.summary       = %q{Sortable table component for Volt.}
  spec.description   = %q{It's a table.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  
  spec.add_development_dependency "rake"

  # Testing gems
  spec.add_development_dependency 'rspec', '~> 3.2.0'
  spec.add_development_dependency 'opal-rspec', '~> 0.4.2'
  spec.add_development_dependency 'capybara', '~> 2.4.4'
  spec.add_development_dependency 'selenium-webdriver', '~> 2.53.0'
  spec.add_development_dependency 'chromedriver-helper', '~> 1.0.0'
  spec.add_development_dependency 'poltergeist', '~> 1.6.0'
  spec.add_development_dependency 'volt-browser_irb'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec', '~> 4.3.0'
  spec.add_development_dependency 'faker', '~> 1.4'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'ruby-progressbar'

  # Gems to run the dummy app
  spec.add_development_dependency 'volt-mongo', '~> 0.2.0'
  spec.add_development_dependency 'volt-bootstrap', '~> 0.1.0'
  spec.add_development_dependency 'volt-bootstrap_jumbotron_theme', '~> 0.1.0'
  spec.add_development_dependency 'volt-user_templates', '~> 0.4.0'
  spec.add_development_dependency 'thin', '~> 1.6.0'
  spec.add_development_dependency 'volt-pagination'

end
