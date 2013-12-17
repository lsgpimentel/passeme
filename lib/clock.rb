require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

#Always when a new day starts
every(1.day, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue TaskBeforeOverdueNotifier.new }

#Always when a new day starts
every(1.day, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue FollowUpNextDayNotifier.new }

#Always in the last day of the month
every(1.month, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue FollowUpNextMonthNotifier.new }

#Always when a new month starts
every(1.month, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue FollowUpPastMonthNotifier.new }
