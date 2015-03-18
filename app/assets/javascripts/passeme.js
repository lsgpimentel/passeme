var init = function() {
  App.init();
  Tasks.initDashboardWidget();
  Modals.init();
  Timetables.init();
  Subjects.init();
  StudySources.init();
  SubjectGroups.init();
  Calendars.init();
  FollowUp.init();
  EventSources.init();
  Reports.init();
  if($('#dashboard-settings').data('show-tour')){
    Tours.dashboard();
  }
  //Tours.timetableCreation();
  Dashboard.init();
};


jQuery(document).ready(function() {
  init();
});

