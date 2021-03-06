# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  navigation.renderer = PassemeMenuRenderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  navigation.selected_class = 'active'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  navigation.active_leaf_class = ''

  # Item keys are normally added to list items as id.
  # This setting turns that off
  navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.  You may also use a proc, or the symbol <tt>:subpath</tt>. 
    #
    primary.item :home, t('navigation.items.dashboard'), root_path, icon: 'icon-home', class: 'start'

    primary.item :planning, t('navigation.items.planning.title'), icon: 'icon-edit', id: "menu-planning" do |sub_nav|
      sub_nav.item :subjects, t('navigation.items.planning.subjects'), subjects_path, id: "menu-planning-subjects"
      sub_nav.item :subject_groups, t('navigation.items.planning.subject_groups'), subject_groups_path, id: "menu-planning-subject-groups"
      sub_nav.item :study_sources, t('navigation.items.planning.study_sources'), study_sources_path, id: "menu-planning-study-sources"
    end

    primary.item :timetables, t('navigation.items.timetables'), timetables_path, icon: 'icon-calendar', id: "menu-timetables"
    primary.item :follow_up, t('navigation.items.follow_up'), follow_up_path, icon: 'icon-check', id: "menu-follow-up"
    primary.item :reports, t('navigation.items.reports'), reports_path, icon: 'icon-bar-chart', id: "menu-reports"
    #primary.item :groups, t('navigation.items.groups'), groups_path, icon: 'icon-group'
    primary.item :settings, t('navigation.items.settings'), settings_path, icon: 'icon-cogs', id: "menu-settings"
    primary.item :feedback, t('navigation.items.feedback.title'),  icon: 'icon-thumbs-up', id: 'menu-feedback' do |sub_nav|
      #sub_nav.item :evaluation_form, t('navigation.items.feedback.evaluation_form'), 'https://docs.google.com/forms/d/11CZZugqzOc3CYY_cATA2_MuBQJN62J6n1PIh41iOYbo/viewform', icon: 'icon-check', link: { target: '_blank' }
      sub_nav.item :speak_with_author, t('navigation.items.feedback.speak_with_author'), 'mailto:passemeapp@gmail.com', icon: 'icon-comments', link: { target: '_blank', class: 'dont-block-ui' }, id: "menu-speak-with-author"
    end

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    primary.dom_class = 'page-sidebar-menu'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end

end
