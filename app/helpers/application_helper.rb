module ApplicationHelper

  def full_title(page_title)
    base_title = "PasseMe"
    if(page_title.empty?)
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when :success
      "alert-success"
    when :error
      "alert-error"
    when :alert
      "alert-block"
    when :notice
      "alert-info"
    else
      flash_type.to_s
    end
  end

  #					<li class="dropdown language">
  #						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
  #						<img alt="" src="assets/img/flags/us.png" />
  #						<span class="username">US</span>
  #						<i class="icon-angle-down"></i>
  #						</a>
  #						<ul class="dropdown-menu">
  #							<li><a href="#"><img alt="" src="assets/img/flags/es.png" /> Spanish</a></li>
  #							<li><a href="#"><img alt="" src="assets/img/flags/de.png" /> German</a></li>
  #							<li><a href="#"><img alt="" src="assets/img/flags/ru.png" /> Russian</a></li>
  #							<li><a href="#"><img alt="" src="assets/img/flags/fr.png" /> French</a></li>
  #						</ul>
  #					</li>

  def language_dropdown
    content_tag :li, class: "dropdown language" do
      concat(content_tag(:a, href: '#', class: "dropdown-toggle", data: { toggle: "dropdown", hover: "dropdown", "close-others" => "true" }) {

        concat content_tag(:img, '', src: "assets/flags/#{I18n.locale}.png")
        concat t("translation.#{I18n.locale}")
        concat content_tag(:i, '', class: "icon-angle-down")
      })

      concat( content_tag(:ul, class: "dropdown-menu") do
        I18n.available_locales.each do |locale|
          if locale != I18n.locale
            concat(content_tag(:li) {
              link_to  url_for(locale: locale.to_s) do
                concat content_tag(:img, '', src: "assets/flags/#{locale}.png")
                concat t("translation.#{locale}")
              end
            })
          end
        end
      end)
    end
  end


end
