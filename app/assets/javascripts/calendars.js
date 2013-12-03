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
      eventResize: function (event,dayDelta,minuteDelta,revertFunc,jsEvent,ui,view) {
        var data = {'dayDelta': dayDelta,'minuteDelta': minuteDelta,'eventId': event.id};
        var url = $(this).closest('.calendar-init').data('url-event-resize');
        App.ajax("POST", url, data, {
          reloadUniform: false
        });
      },
      select: function (startDate,endDate,allDay,jsEvent,view) {
        var data = {'startDate': startDate.getTime(),'endDate': endDate.getTime(),'allDay': allDay,'viewName': view.name};
        var url = $(this).closest('.calendar-init').data('url-select');
        App.ajax("POST", url, data, {
          reloadUniform: false
        });
      },
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
          reloadUniform: false
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

  var new_event = function() {
      //Moving the element (with append) to the top left of the calendar
    $('.fc-header-left').append($("#new-event").closest("form"));

    $("#new-event").on('click', function(e){
      e.preventDefault();

      var url = $(this).closest('form').attr('action');
      App.ajax("GET", url, {}, {
        reloadUniform: false
      });

    });

  }

  return {
    //main function to initiate the module
    init: function () {
      initCalendar();
      new_event();
    },


  };

}();
