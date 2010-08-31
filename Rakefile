require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'stub_factory'
    gem.summary = %Q{Simple stubbed factories for Rspec}
    gem.description = %Q{Simple stubbed factories for Rspec}
    gem.email = 'james@logi.cl'
    gem.homepage = 'http://github.com/jcf/stub_factory'
    gem.authors = ['James Conroy-Finn']
    gem.add_development_dependency 'rspec', '>= 1.2.9'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end

begin
  require 'reek/rake/task'
  Reek::Rake::Task.new do |t|
    t.fail_on_error = false
    t.verbose = true
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort 'Reek is not available. In order to run reek, you must: sudo gem install reek'
  end
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "stub_factory #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
