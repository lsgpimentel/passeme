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
  end
end
