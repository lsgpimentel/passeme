require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

#Running at the day start
every(1.day, 'Queueing Task Before Overdue Notifier', :at => '00:01') { Delayed::Job.enqueue TaskBeforeOverdueNotifier.new }
every(1.day, 'Queueing Ask For Evaluation Notifier', :at => '01:01') { Delayed::Job.enqueue AskForEvaluationNotifier.new }

#Running near the end of the day
every(1.day, 'Queueing Follow Up Next Day Notifier', :at => '20:00') { Delayed::Job.enqueue FollowUpNextDayNotifier.new }

#Running in the last day of the month
every(1.month, 'Queueing Follow Up Next Month Notifier', :if => lambda { |t| t.day == Date.current.end_of_month.day }) { Delayed::Job.enqueue FollowUpNextMonthNotifier.new }

#Running in the first day of the month
every(1.month, 'Queueing Follow Up Past Month Notifier', :if => lambda { |t| t.day == Date.current.at_beginning_of_month.day }) { Delayed::Job.enqueue FollowUpPastMonthNotifier.new }
