class BootstrapBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.content_tag(:ul, :class => 'breadcrumb') do
      elements_count = @elements.size
      i = 0
      @elements.collect do |element|
        i += 1
        render_element(element, last = (i == elements_count))
      end.join.html_safe
    end
  end

  def render_element(element, last = false)

    @context.content_tag(:li, :class => ('active' if last)) do
      home_icon = @context.content_tag(:i, '', :class => 'icon-home') if element.path == :root_path
      divider = @context.content_tag(:i, '', :class => 'icon-angle-right') unless last

      if last
        item = compute_name(element)
      else
        item = @context.link_to(compute_name(element), compute_path(element), element.options)
      end

      ((home_icon || '') << item << (divider || '')).html_safe
    end

    #if @options[:date_range_picker] && last
    #  li << render_date_range_picker
    #end
  end

  def render_date_range_picker
    @context.content_tag(:li, class: "pull-right no-text-shadow") do
      @context.content_tag(:div, class: "dashboard-date-range tooltips no-tooltip-on-touch-device responsive", data: { tablet: "", desktop: "tooltips", placement: "top", :"original-title" => "Change dashboard date range" } ) do
        @context.concat @context.content_tag(:i, '', class: "icon-calendar")
        @context.concat @context.content_tag(:span, '')
        @context.concat @context.content_tag(:i, '', class: "icon-angle-down")
      end
    end
  end

end
