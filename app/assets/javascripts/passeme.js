var init = function() {
  App.init();
  FormEditable.init();
  Tasks.initDashboardWidget();
  Modals.init();
  Calendar.init();
  FormWizard.init();
  Timetables.init();
  Subjects.init();
  StudySources.init();
  SubjectGroups.init();
};


jQuery(document).ready(function() {
  init();
});

