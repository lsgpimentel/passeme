class PassemeMenuRenderer < SimpleNavigation::Renderer::Base 







  # def_delegators SimpleNavigation.adapter.template, :button_tag

  def render(item_container)

    #Wrap the menu in a div
    #adapter.template.content_tag :div, class: 'page-sidebar nav-collapse collapse' do

    list_content = item_container.items.inject([]) do |list, item|
      #Insert the toggler_button and the search field before the menu items
      if item_container.items.first == item && item_container.level == 1
        list << toggler_button
        list << search
      end


      li_options = item.html_options.reject {|k, v| k == :link}
      icon = li_options.delete(:icon)
      li_content = tag_for(item, item.name, icon)
      if include_sub_navigation?(item)
        item.sub_navigation.dom_class = [item.sub_navigation.dom_class, 'sub-menu'].flatten.compact.join(' ')
        li_content << render_sub_navigation_for(item)
      end
      list << content_tag(:li, li_content, li_options)
    end.join
    if skip_if_empty? && item_container.empty?
      ''
    else
      content_tag(:ul, list_content, {:id => item_container.dom_id, :class => item_container.dom_class})
    end
    #end

  end

  protected

  def tag_for(item, name = '', icon = nil)
    unless item.url or include_sub_navigation?(item)
      return item.name
    end
    url = item.url
    link = Array.new
    link << content_tag(:i, '', :class => [icon].flatten.compact.join(' ')) unless icon.nil?
    link << content_tag(:span, name, class: 'title')
    link << content_tag(:span, '', class: 'selected') if item.selected?

    if include_sub_navigation?(item)
      link << content_tag(:span, '', class: "arrow#{' open' if item.selected?}")

      item_options = item.html_options

      item_options[:link] = Hash.new if item_options[:link].nil?
      item_options[:link][:class] = Array.new if item_options[:link][:class].nil?
      item_options[:link][:href] = 'javascript:;'
      item.html_options = item_options
    end
    link_to(link.join(" ").html_safe, url, options_for(item))
  end

  #Sidebar Toggler Button
  def toggler_button
    adapter.template.content_tag(:li) do
      content_tag :div, '', class: 'sidebar-toggler hidden-phone'
    end
  end

  def search
    adapter.template.content_tag(:li) do
      adapter.template.form_tag '', class: 'sidebar-search' do
        adapter.template.content_tag :div, class: 'input-box' do
          adapter.template.concat adapter.template.content_tag(:a, nil, href: 'javascript:;', class: 'remove')
          adapter.template.concat adapter.template.text_field_tag 'search', nil, placeholder: "Search..."
          adapter.template.concat adapter.template.submit_tag '', { class: 'submit' }
        end
      end
    end
  end


end
