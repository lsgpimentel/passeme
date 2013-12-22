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
};


jQuery(document).ready(function() {
  init();
});

