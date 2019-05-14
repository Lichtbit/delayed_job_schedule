$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'delayed_job_schedule/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'delayed_job_schedule'
  s.version     = DelayedJobSchedule::VERSION
  s.authors     = ['Georg Limbach']
  s.email       = ['georg.limbach@lichtbit.com']
  s.homepage    = 'https://lichtbit.com'
  s.summary     = 'A plugin for delayed_job to schedule simple tasks.'
  s.description = 'A plugin for delayed_job to schedule simple tasks. It does not need a seperate worker and reduce ' \
                  'the memory usage.'
  s.license     = 'MIT'

  s.files = Dir['lib/**/*', 'MIT-LICENSE', 'README.rdoc']

  s.add_dependency 'delayed_job'
  s.add_dependency 'rails'
end
