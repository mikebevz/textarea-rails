# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'textarea-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "textarea-rails"
  gem.version       = Textarea::Rails::VERSION
  gem.authors       = ["Michael Bevz"]
  gem.email         = ["myb@appfellas.co"]
  gem.description   = "Markdown editor"
  gem.summary       = "Markdown editor"
  gem.homepage      = "http://github.com/mikebevz/textarea-rails"

  gem.files = Dir["{lib,vendor}/**/*"] + ["LICENSE.txt", "README.md"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "railties", "~> 3.1"
end
