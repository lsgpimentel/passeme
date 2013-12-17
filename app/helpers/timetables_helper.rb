module TimetablesHelper

  def link_to_new_time(day)
    content_tag :a, class: "btn green add-time popovers", data: { day: day } do
      content_tag :i, '', class: "icon-plus"
    end
  end

  def show_complete_button(event_instance)
    date = event_instance.start.to_date
    if date < Date.current
      button_to calendar_calendar_event_edit_complete_path(event_instance.event.calendar_event_source.calendar, event_instance.event, start: event_instance.start, end: event_instance.end), method: :get, remote: true, class: 'btn green complete' do
        content_tag :i, '', class: "icon-check"
      end
    end
  end

end
