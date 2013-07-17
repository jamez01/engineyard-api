# -*- encoding: utf-8 -*-
#
require File.expand_path('../lib/engineyard-api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name    = 'engineyard-api'
  gem.version = EngineyardAPI::VERSION
  gem.summary = 'Ruby Wrapper for Engine Yard API '
  gem.description = 'Ruby Wrapper for Egnine Yard API'
  gem.author   = 'James Paterni'
  gem.email    = 'jpaterni@engineyard.com'
  gem.homepage = ''

  gem.add_dependency('httparty')
  gem.add_dependency('json')

  # These dependencies are only for people who work on this gem
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'rspec'

  # Include everything in the lib folder
  gem.files = Dir['./lib/**/*']
  gem.files = %w(README.md) + Dir.glob("lib/**/*")

  # Supress the warning about no rubyforge project
  #gem.rubyforge_project = 'nowarning'
end
