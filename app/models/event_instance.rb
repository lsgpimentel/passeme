class EventInstance
  include ActiveModel::AttributeMethods

  attr_accessor :title, :start, :end, :id, :color, :background_color, :textColor, :event

  def self.follow_up_occurrences_between(calendar, begin_date,end_date)
    events = self.events(calendar, begin_date, end_date)
    items_studied = calendar.follow_up_items.studied
    events.map { |event|
      event.schedule.occurrences_between(begin_date,end_date).map { |date|
        i = EventInstance.new()
        i.event = event
        i.start = date.utc
        i.end = date.utc + event.duration

        if event.father_id.present?
          id = event.father_id
          title = "Review " + event.subject.name
        else
          id = event.id
          title = event.subject.name
        end

        i.id = id
        i.title = title

        #TODO Se o start, o end, o date, e o event estiverem no follow_up_items
        #então não retornar o event_instance
        if not items_studied.any? { |f| f.date == date.to_date && f.from_time == i.start.to_time && f.to_time == i.end.to_time }
          i
        end
      }
    }.flatten.sort! {|x,y| x.start <=> y.start }
  end

  def self.calendar_occurrences_between(calendar, begin_date,end_date)
    events = self.events(calendar, begin_date, end_date)
    events.map { |event|
      event.schedule.occurrences_between(begin_date,end_date).map { |date|
        #start
        #end

        i = EventInstance.new()
        i.color = event.calendar_event_source.color
        i.start = date
        i.end = date + event.duration
        i.textColor = '#000'

        if event.father_id.present?
          id = event.father_id
          title = "Review " + event.subject.name
        else
          id = event.id
          title = event.subject.name
        end

        i.id = id
        i.title = title

        i
      }
    }.flatten.sort! {|x,y| x.start <=> y.start }
  end

  # Using Squeel
  # line 1 = Event doesn't repeat, but ends in window
  # line 2 = Event starts before our end date and repeats until a certain point of time, and that point of time after our begin date
  # line 3 = Event starts before our end date and repeats for N times
  # line 4 = Event repeats indefinitely, then all we care about is that it has started at somepoint in the past
  def self.events(calendar, begin_date, end_date)
    calendar.calendar_events.where(
      "(repeats = 'never' AND date >= :start AND date <= :end) OR " +
      "(repeats != 'never' AND date <= :end AND repeat_ends = 'on' AND repeat_ends_on >= :start) OR " +
      "(repeats != 'never' AND date <= :end AND repeat_ends = 'count') OR " +
      "(repeats != 'never' AND repeat_ends = 'never' AND date <= :end)",
      { start: begin_date, end: end_date }
    )
  end

end
