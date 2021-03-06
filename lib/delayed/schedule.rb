module Delayed
  class Schedule < Plugin
    callbacks do |lifecycle|
      lifecycle.before(:loop) do |worker, *_args|
        Delayed::Schedule.run_tasks if Delayed::Schedule.run?(worker)
      end
    end

    def self.run_tasks
      @schedule_tasks ||= []
      @schedule_tasks.select(&:run_necessary?).each do |task|
        task.perform
      rescue StandardError => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join("\n")
      end
    end

    def self.every(time_range, &block)
      @schedule_tasks ||= []
      @schedule_tasks.push(ScheduleTask.new(time_range, block))
    end

    def self.worker_select=(proc)
      @worker_select = proc
    end

    def self.run?(worker)
      !@worker_select.respond_to?(:call) || @worker_select.call(worker)
    end

    ScheduleTask = Struct.new(:time_range, :block, :last_run) do
      def run_necessary?
        self.last_run ||= Time.now.in_time_zone
        last_run.nil? || (last_run + time_range) < Time.now.in_time_zone
      end

      def perform
        self.last_run = Time.now.in_time_zone
        block.call
      end
    end
  end
end
