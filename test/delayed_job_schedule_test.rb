require 'test_helper'
require 'minitest/mock'

class DelayedJobScheduleTest < ActiveSupport::TestCase
  test "truth" do

    executed = false

    Delayed::Schedule.every(1.minute) { executed = true }
    refute executed
    
    Delayed::Schedule.run_tasks
    refute executed

    Time.stub :now, DateTime.tomorrow.midday do
      Delayed::Schedule.run_tasks
      assert executed
    end
  end
end
