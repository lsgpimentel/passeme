class TimePickerInput < SimpleForm::Inputs::StringInput
  def input
    input_html_options[:type] = 'text'
    input_html_options[:class] << "timepicker-24 input-mini"

    template.content_tag :div, class: 'input-append bootstrap-timepicker' do
      input = super # leave StringInput do the real rendering
      input += template.content_tag :span, class: 'add-on' do
        template.content_tag :i, '', class: 'icon-time'
      end
      input
    end
  end
end
