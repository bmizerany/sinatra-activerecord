Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name = 'sinatra-activerecord'
  s.version = '0.1.3'
  s.date = '2009-09-21'

  s.description = "Extends Sinatra with activerecord helpers for instant activerecord use"
  s.summary = s.description

  s.authors = ["Blake Mizerany"]
  s.email = "blake.mizerany@gmail.com"

  # = MANIFEST =
  s.files = %w[
    README.md
    lib/sinatra/activerecord.rb
    lib/sinatra/activerecord/rake.rb
    sinatra-activerecord.gemspec
  ]
  # = MANIFEST =

  s.extra_rdoc_files = %w[README.md]
  s.add_dependency 'sinatra',    '>= 0.9.4'

  s.has_rdoc = true
  s.homepage = "http://github.com/rtomayko/sinatra-activerecord"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Sinatra::ActiveRecord"]
  s.require_paths = %w[lib]
  s.rubyforge_project = 'bmizerany'
  s.rubygems_version = '1.1.1'
end
