var Calendars = function () {

  var initCalendar = function () {

    if (!jQuery().fullCalendar) {
      return;
    }

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $('.portlet.calendar .calendar-init').fullCalendar('destroy'); // destroy the calendar
    $('.portlet.calendar .calendar-init').fullCalendar({ //re-initialize the calendar
      selectable: true,
      selectHelper: false,
      header: { left: '', center: 'title', right: 'prev,next,today,month,agendaWeek,agendaDay' },
      buttonText: { today: 'Hoje', day: 'Dia', week: 'Semana', month: 'Mês'},
      allDaySlot: false,
      columnFormat: { day: 'dddd, dd / MM / yyyy', week: 'ddd, dd / MM'},
      titleFormat: { day: 'dddd, dd / MM / yyyy', week: "dd/MM[/yyyy]{ '&#8212;' dd/MM[/yyyy]}", month: 'MMMM/yyyy'},
      monthNames: [ 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro' ],
      monthNamesShort: [ 'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez' ],
      dayNames: [ 'Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado' ],
      dayNamesShort: [ 'Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb' ],
      firstDay: 1,
      axisFormat: 'H:mm',
      timeFormat: 'H:mm{ - H:mm}',
      slotMinutes: 15,
      editable: true,
      eventDurationEditable: false,
      /*eventResize: function (event,dayDelta,minuteDelta,revertFunc,jsEvent,ui,view) {
        var data = {'dayDelta': dayDelta,'minuteDelta': minuteDelta,'eventId': event.id};
        var url = $(this).closest('.calendar-init').data('url-event-resize');
        App.ajax("POST", url, data, {
        reloadUniform: false
        });
        },*/
      /*select: function (startDate,endDate,allDay,jsEvent,view) {
        var data = {'startDate': startDate.getTime(),'endDate': endDate.getTime(),'allDay': allDay,'viewName': view.name};
        var url = $(this).closest('.calendar-init').data('url-select');
        App.ajax("POST", url, data, {
        reloadUniform: false
        });
        },*/
      eventDrop: function (event,dayDelta,minuteDelta,allDay,revertFunc,jsEvent,ui,view) {
        var data = {'dayDelta': dayDelta,'minuteDelta': minuteDelta,'allDay': allDay,'eventId': event.id};
        var url = $(this).closest('.calendar-init').data('url-event-drop');
        App.ajax("POST", url, data, {
          reloadUniform: false
        });
      },
      eventSources: $(this).closest('.calendar-init').data('url-event-sources'),
      dayClick: function (date,allDay,jsEvent,view) {
        var data = {'date': date.getTime(),'allDay': allDay,'viewName': view.name};
        var url = $(this).closest('.calendar-init').data('url-day-click');
        App.ajax("POST", url, data, {
          reloadUniform: false,
          reloadTimepicker: true,
          reloadDatepicker: true,
          ajaxSuccess : function(data, status, xhr) {
            initModalEvent();
          }
        });
      },
      eventClick: function (event,jsEvent,view) {
        var data = {'eventId': event.id,'viewName': view.name};
        var url = $(this).closest('.calendar-init').data('url-event-click');
        App.ajax("POST", url, data, {
          reloadUniform: false
        });
      }
    });


  };

  var eventSourceSelection = function(){
    function format(es){
      if (!es.id) return es.text; // optgroup
      return '<span class="option-color" style="background-color: ' + $(es.element).data("color") + '">&nbsp;&nbsp;</span>' + es.text;
    }
    $("#calendar_event_calendar_event_source_id").select2({
      allowClear: true,
      formatResult: format,
      formatSelection: format,
      escapeMarkup: function (m) {
        return m;
      }
    });

    $("#calendar_event_study_source_id").select2({
    });
  }


  var initSchedule = function() {
    var toggle_repeats_yearly_on = function(){
      if($('#calendar_event_repeats_yearly_on').is(':checked')){
        $('#event_repeats_yearly_on_options').show();
      } else {
        $('#event_repeats_yearly_on_options').hide();
      }
    }
    toggle_repeats_yearly_on();
    $('#calendar_event_repeats_yearly_on').on('change',function(){
      toggle_repeats_yearly_on();
    });
    var toggle_event_times = function(){
      $('.event_time').show();
    }
    toggle_event_times();
    var toggle_event_options = function(){
      $('.event_option').hide();
      switch ($('#calendar_event_repeats').val())
      {
        case 'never':
          // Nothing
          break;
        case 'daily':
          $('#repeats_options').show();
        $('#repeats_daily_options').show();
        break;
        case 'weekly':
          $('#repeats_options').show();
        $('#repeats_weekly_options').show();
        break;
        case 'monthly':
          $('#repeats_options').show();
        $('#repeats_monthly_options').show();
        break;
        case 'yearly':
          $('#repeats_options').show();
        $('#repeats_yearly_options').show();
        break;
      }
    }
    toggle_event_options();
    $('#calendar_event_repeats').on('change',function(){
      toggle_event_options();
    });
    var toggle_repeat_ends_on = function(){
      switch ($('#calendar_event_repeat_ends').val())
      {
        case 'never':
          $('#event_repeat_ends_on').hide();
        break;
        case 'on':
          $('#event_repeat_ends_on').show();
        break;
      }
    }
    toggle_repeat_ends_on();
    $('#calendar_event_repeat_ends').on('change',function(){
      toggle_repeat_ends_on();
    });
    var toggle_repeats_monthly = function(){
      switch ($('#calendar_event_repeats_monthly').val())
      {
        case 'each':
          $('#event_repeats_monthly_each').show();
        $('#event_repeats_monthly_on').hide();
        break;
        case 'on':
          $('#event_repeats_monthly_each').hide();
        $('#event_repeats_monthly_on').show();
        break;
      }
    }
    toggle_repeats_monthly();
    $('#calendar_event_repeats_monthly').on('change',function(){
      toggle_repeats_monthly();
    });
  }

  var initModalEvent = function() {
    eventSourceSelection();
    initSchedule();
  }

  var new_event = function() {
    //Moving the element (with append) to the top left of the calendar
    $('.fc-header-left').append($("#new-event").closest("form"));

    $("#new-event").on('click', function(e){
      e.preventDefault();

      var url = $(this).closest('form').attr('action');
      App.ajax("GET", url, {}, {
        reloadUniform: false,
        reloadTimepicker: true,
        reloadDatepicker: true,
        ajaxSuccess : function(data, status, xhr) {
          initModalEvent();
        }
      });

    });

  }

  var timetables = function(){
    App.ajaxRailsUJS(".activate-timetable", {
      reloadUniform: false
    });
  }

  return {
    //main function to initiate the module
    init: function () {
      initCalendar();
      new_event();
      timetables();
    },


  };

}();
