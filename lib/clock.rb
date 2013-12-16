require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(1.day, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue TaskBeforeOverdueNotifier.new }
every(1.day, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue FollowUpNextDayNotifier.new }
every(1.month, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue FollowUpNextMonthNotifier.new }
every(1.month, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue FollowUpPastMonthNotifier.new }
