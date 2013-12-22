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
  }

  var initReports = function(data){
    if(data.follow_up_not_studied_reason){
      $.plot($("#follow_up_not_studied_reason .chart"), data.follow_up_not_studied_reason, {
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



  }


  return {
    init: function(){
      timetableSelect();
    }
  }

}();
