var Timetables = function () {

  var handleTimePickers = function () {

    if (jQuery().timepicker) {
      $('.timepicker-24').timepicker({
        minuteStep: 5,
        showMeridian: false,
        defaultTime: '00:00',
        disableFocus: true
      });
    }
  }

  var initDrag = function (el) {
    // make the event draggable using jQuery UI
    el.draggable({
      zIndex: 999,
      revert: true, // will cause the event to go back to its
      revertDuration: 0 //  original position after the drag
    });
  }

  var getProductivityStars = function(n){
    var html = '';
    for(i=0; i<n; i++){
      html += '<div class="star-rating star-rating-hover"></div>';
    }
    return html;

  }

  var addTimeToList = function (from, to, productivity) {
    var title = from + " - " + to;
    var html = $('<div class="external-event label">'
                 + '<p><strong>' + title + '</strong></p>'
                 + getProductivityStars(productivity)
                 + '</div>');
                 jQuery('#time-list').append(html);
                 initDrag(html);
  }

  var addTimeClickEvent = function(){

    $('#add-time').unbind('click').click(function () {
      var from = $.trim($('#time-from').val());
      var to = $.trim($('#time-to').val());
      var productivity = $("input[name=productivity]:checked").val();

      if(from != '' && to != '' && productivity > 0) {
        addTimeToList(from, to, productivity);
        $('.timepicker-24').timepicker('clear');
        $('.rating-cancel').trigger('click'); //Had to trigger the cancel onclick event, since calling the select with empty argument had no effect
      }
    });
  }

  var dragTime = function (){
    $('#external-events div.external-event').each(function () {
      initDrag($(this))
    });

  }


  var loadTimes = function(){
    //predefined events
    $('#time-list').html("");
    addTimeToList("15:10", "15:20", 4);
    addTimeToList("15:10", "15:20", 4);
    addTimeToList("15:10", "15:20", 4);
    addTimeToList("15:10", "15:20", 4);
    addTimeToList("15:10", "15:20", 4);
  }


  var initStudyTimeStep = function(){
    handleTimePickers();
    dragTime();
    loadTimes();
    addTimeClickEvent();
  }

  return {
    init: function () {
      initStudyTimeStep();
    }
  };

}();
