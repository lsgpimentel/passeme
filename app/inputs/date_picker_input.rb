class DatePickerInput < SimpleForm::Inputs::StringInput
  def input
    input_html_options[:type] = 'text'
    input_html_options[:class] << "date-picker input-small"

    template.content_tag :div, class: 'input-append date date-picker' do
      input = super # leave StringInput do the real rendering
      input += template.content_tag :span, class: 'add-on' do
        template.content_tag :i, '', class: 'icon-calendar'
      end
      input
    end
  end
end
