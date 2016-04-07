module Delayed
  class Schedule < Plugin

    callbacks do |lifecycle|
      lifecycle.before(:loop) do |worker, *args, &block|
        Delayed::Schedule.run_tasks
      end
    end

    def self.run_tasks
      @schedule_tasks ||= []
      @schedule_tasks.select(&:run_necessary?).each do |task|
        begin
          task.perform
        rescue Exception => e
          Rails.logger.error e.message
          Rails.logger.error e.backtrace.join("\n")
        end
      end
    end

    def self.every(time_range, &block)
      @schedule_tasks ||= []
      @schedule_tasks.push(ScheduleTask.new(time_range, block))
    end

    class ScheduleTask < Struct.new(:time_range, :block, :last_run)
      def run_necessary?
        self.last_run ||= Time.now
        last_run.nil? || (last_run + time_range) < Time.now
      end

      def perform
        self.last_run = Time.now
        block.call
      end
    end
  end
end
