module DelayedJobSchedule
  class Engine < ::Rails::Engine
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    initializer 'delayed_job_schedule' do |_app|
      Delayed::Worker.plugins << Delayed::Schedule
    end
  end
end
