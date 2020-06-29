# -*- encoding: utf-8 -*-
# stub: jquery-easing-rails 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery-easing-rails".freeze
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrew Kozloff".freeze]
  s.date = "2014-10-22"
  s.description = "Jquery easing plugin for Rails 3.1+ asset pipeline".freeze
  s.email = ["demerest@gmail.com".freeze]
  s.homepage = "https://github.com/rocsci/jquery-easing-rails".freeze
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Jquery easing plugin for Rails 3.1+ asset pipeline".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.0.0"])
    s.add_development_dependency(%q<rails>.freeze, [">= 3.1.0"])
    s.add_development_dependency(%q<gem-release>.freeze, [">= 0.4.1"])
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0.0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1.0"])
    s.add_dependency(%q<gem-release>.freeze, [">= 0.4.1"])
  end
end
