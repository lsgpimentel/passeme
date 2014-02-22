var Reports = function() {


  var timetableSelect = function(){
    $("#timetable-select").select2();
    $("#timetable-select").on('change', function(e){
      var url = $(this).data("url-callback");
      var id = e.val || this.value;
      App.ajax("GET", url, { timetable_id: id }, {
        ajaxSuccess : function(data, status, xhr) {
          initReports(data);
        }
      });
    });

    //Trigger the onchange so the charts get filled when the screen is opened for the first time
    $("#timetable-select").trigger('change');
  };

  function addReportFollowUpNotStudiedReason(data){
    $.plot($("#follow_up_not_studied_reason .chart"), data, {
      series: {
        pie: {
          show: true
        }
      },
      legend: {
        show: false
      }
    });
  }

  function addReportExpectedAndAccomplished(data){
    $.plot($("#expected_and_accomplished .chart"),
           [{
             bars: { show: true, barWidth: 0.6, align: "center" },
             data: data.hours
           }],
           {
             xaxis: {
               ticks: data.labels
             },
             grid: {
               hoverable: true,
               borderWidth: 1
             }
           });
  }

  function addReportStudyHoursEvolution(data){
    $.plot($("#study_hours_evolution .chart"),
           [{
             lines: { show: true, align: "center" },
             data: data.hours
           }],
           {
             xaxis: {
               ticks: data.labels
             },
             grid: {
               hoverable: true,
               borderWidth: 1
             }
           });
  }

  var initReports = function(data){
    if(data.follow_up_not_studied_reason){
      addReportFollowUpNotStudiedReason(data.follow_up_not_studied_reason);
    }

    if(data.expected_and_accomplished){
      addReportExpectedAndAccomplished(data.expected_and_accomplished);
    }

    if(data.study_hours_evolution){
      addReportStudyHoursEvolution(data.study_hours_evolution);
    }


  };


  return {
    init: function(){
      timetableSelect();
    }
  };

}();
