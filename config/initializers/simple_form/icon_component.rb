module SimpleForm
  module Components
    module Icon
      def icon
        return icon_class if options[:icon].present?
      end

      def icon_class
        return template.content_tag(:i, '', class: options[:icon])
      end
    end
  end
end
SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Icon)

