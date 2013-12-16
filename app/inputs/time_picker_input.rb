class TimePickerInput < SimpleForm::Inputs::StringInput

  def input
    value = object.send(attribute_name) if object.respond_to? attribute_name
    display_pattern = I18n.t('timepicker.dformat', :default => '%R')
    input_html_options[:value] ||= I18n.localize(value, :format => display_pattern) if value.present?

    input_html_options[:type] = 'text'

    input_html_options[:class] << "timepicker-24 input-mini"

    template.content_tag :div, class: 'input-append bootstrap-timepicker' do
      input = super # leave StringInput do the real rendering
      input += template.content_tag :span, class: 'add-on' do
        template.content_tag :i, '', class: 'icon-time', data: { 'time-icon' => 'icon-time', 'date-icon' => 'icon-calendar' }
      end
      input
    end
  end
end
