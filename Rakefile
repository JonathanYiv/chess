require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |task|
	task.rspec_opts = "-fdoc" # this passes in the -fdoc flag
end

task :default => :spec