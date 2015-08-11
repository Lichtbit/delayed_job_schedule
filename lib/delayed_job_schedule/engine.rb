module DelayedJobSchedule
  class Engine < ::Rails::Engine
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    initializer "delayed_job_schedule" do |app|
      Delayed::Worker.plugins << Delayed::Schedule
    end
  end
end
