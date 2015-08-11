$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "delayed_job_schedule/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "delayed_job_schedule"
  s.version     = DelayedJobSchedule::VERSION
  s.authors     = ["Georg Limbach"]
  s.email       = ["glimbach@milabent.com"]
  s.homepage    = "http://milabent.com"
  s.summary     = "A plugin for delayed_job to schedule simple tasks."
  s.description = "A plugin for delayed_job to schedule simple tasks. It does not need a seperate worker and reduce the memory usage."
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "delayed_job"
  s.add_dependency "rails"
end
