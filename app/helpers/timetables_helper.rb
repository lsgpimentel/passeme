module TimetablesHelper

  def link_to_new_time(day)
    content_tag :a, class: "btn green add-time popovers", data: { day: day } do
      content_tag :i, '', class: "icon-plus"
    end
  end

end
