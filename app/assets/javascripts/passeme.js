var init = function() {
  App.init();
  FormEditable.init();
  Tasks.initDashboardWidget();
  Modals.init();
  Timetables.init();
  Subjects.init();
  StudySources.init();
  SubjectGroups.init();
  Calendars.init();
};


jQuery(document).ready(function() {
  init();
});

