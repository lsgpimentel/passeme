var Tours = function(){

  var getDashboardTour = function(){
    var toggleMakeTourOnLoginEvent = function() {
      var url = $('#dashboard-settings').data('toggle-tour-url');
      var data = { _method: "PUT" };

      App.ajax("POST", url, data, {
        elementToBlock: $(this).closest('.popover.tour-tour')
      });
    };

    var getToggleMakeTourOnLoginCheckbox = function(){
      return $('<label>' + I18n.dashboard.tours.checkbox_end_tour + '</label>').prepend($('<input type="checkbox" id="toggle-make-tour-on-login" />'));
    };

    return new Tour({
      template: 
        '<div class="popover" role="tooltip">' +
        '	<div class="arrow"></div>' +
        '	<h3 class="popover-title"></h3>' +
        '	<div class="popover-content"></div>' +
        '	<div class="popover-navigation">' +
        '		<div class="btn-group"> <button class="btn btn-sm btn-default blue" data-role="prev">&laquo; ' + I18n.tour_buttons.previous + '</button> <button class="btn btn-sm btn-default green" data-role="next">' + I18n.tour_buttons.next + ' &raquo;</button> <button class="btn btn-sm btn-default" data-role="pause-resume" data-pause-text="' + I18n.tour_buttons.pause + '" data-resume-text="' + I18n.tour_buttons.continue + '">' + I18n.tour_buttons.pause + '</button> </div>' +
        '		<button class="btn btn-sm btn-default red" data-role="end">' + I18n.tour_buttons.end + '</button> ' +
        '	</div>' +
        '</div>',
      backdrop: true,
      //onStart: function() {
      //  return $button.addClass("disabled", true);
      //},
      //onEnd: function() {
      //  return $button.removeClass("disabled", true);
      //},
      debug: false,
      steps: [
        {
        path: "/",
        title: I18n.dashboard.tours.welcome.title,
        content: I18n.dashboard.tours.welcome.content,
        orphan: true
      }, {
        path: "/",
        element: ".page-sidebar",
        placement: "right",
        title: I18n.dashboard.tours.menu.title,
        content: I18n.dashboard.tours.menu.content
      }, {
        path: "/",
        element: "#menu-planning",
        placement: "right",
        title: I18n.dashboard.tours.menu_planning.title,
        content: I18n.dashboard.tours.menu_planning.content,
        onShow: function(){
          if(!$('#menu-planning').hasClass('open')){
            $('#menu-planning > a').trigger('click');
          }
        }
      }, {
        path: "/",
        element: "#menu-planning-subjects",
        placement: "right",
        title: I18n.dashboard.tours.subjects.title,
        content: I18n.dashboard.tours.subjects.content
      }, {
        path: "/",
        element: "#menu-planning-subject-groups",
        placement: "right",
        title: I18n.dashboard.tours.subject_groups.title,
        content: I18n.dashboard.tours.subject_groups.content
      }, {
        path: "/",
        element: "#menu-planning-study-sources",
        placement: "right",
        title: I18n.dashboard.tours.study_sources.title,
        content: I18n.dashboard.tours.study_sources.content
      }, {
        path: "/",
        element: "#menu-follow-up",
        placement: "right",
        title: I18n.dashboard.tours.follow_up.title,
        content: I18n.dashboard.tours.follow_up.content
      }, {
        path: "/",
        element: "#menu-reports",
        placement: "right",
        title: I18n.dashboard.tours.reports.title,
        content: I18n.dashboard.tours.reports.content
      }, {
        path: "/",
        element: "#menu-settings",
        placement: "right",
        title: I18n.dashboard.tours.settings.title,
        content: I18n.dashboard.tours.settings.content
      }, {
        path: "/",
        element: "#menu-feedback",
        placement: "right",
        title: I18n.dashboard.tours.feedback.title,
        content: I18n.dashboard.tours.feedback.content,
        onShow: function(){
          if(!$('#menu-feedback').hasClass('open')){
            $('#menu-feedback > a').trigger('click');
          }
        }
      }, {
        path: "/",
        element: ".tasks-widget",
        placement: "right",
        title: I18n.dashboard.tours.tasks.title,
        content: I18n.dashboard.tours.tasks.content,
      }, {
        path: "/",
        element: "#header-task-bar",
        placement: "bottom",
        title: I18n.dashboard.tours.pending_tasks.title,
        content: I18n.dashboard.tours.pending_tasks.content
      }, {
        path: "/",
        element: "#header-user-bar",
        placement: "bottom",
        title: I18n.dashboard.tours.second_menu.title,
        content: I18n.dashboard.tours.second_menu.content
      }, {
        path: "/",
        element: "#dashboard",
        placement: "top",
        title: I18n.dashboard.tours.dashboard.title,
        content: I18n.dashboard.tours.dashboard.content
      }, {
        path: "/",
        orphan: true,
        title: I18n.dashboard.tours.end.title,
        content: function(){
          content = I18n.dashboard.tours.end.content;
          checkbox = $('<p></p>').append(getToggleMakeTourOnLoginCheckbox());
          return content + checkbox[0].outerHTML;
        },
        onShown: function(){
          $('#toggle-make-tour-on-login').uniform();
          $('.popover.tour-tour').on('change', '#toggle-make-tour-on-login', toggleMakeTourOnLoginEvent);
        }
      }

      ]
    });
  };

  var getTimetableCreationTour = function(){

  };

  return {
    dashboard: function(){
      if(!$('#dashboard').length){
        return false;
      }
      tour = getDashboardTour();

      tour.init();
      tour.start();
      tour.restart();
    },

    timetableCreation: function(){
      if(!$('#portlet-wizard-timetable').length){
        return false;
      }
      tour = getTimetableCreationTour();

      //tour.init();
      //tour.start();
      //tour.restart();
    }

  };
}();
