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
      allDayDefault: false,
      ignoreTimezone: false,
      eventStartEditable: false,
      eventDurationEditable: true,
      events: $('.calendar-init').data('url-events'),
      dayClick: function (date,allDay,jsEvent,view) {
        if(view.name == 'month') {
          var data = {'date': date.getTime(),'viewName': view.name};
          var url = $(this).closest('.calendar-init').data('url-day-click');
          App.ajax("POST", url, data, {
            reloadUniform: true,
            reloadTimepicker: true,
            reloadDatepicker: true,
            ajaxSuccess : function(data, status, xhr) {
              initModalEvent();
            }
          });
        }
      },
      eventClick: function (event,jsEvent,view) {
        var data = {'eventId': event.id,'viewName': view.name};
        var url = $(this).closest('.calendar-init').data('url-event-click');
        App.ajax("POST", url, data, {
          reloadUniform: true,
          reloadTimepicker: true,
          reloadDatepicker: true,
          ajaxSuccess : function(data, status, xhr) {
            initModalEvent();
          }
        });
      },
      select: function(startDate, endDate, allDay, jsEvent, view) {
        if(view.name != 'month') {
          var data = {'startDate': startDate.getTime(), 'endDate': endDate.getTime(), 'viewName': view.name};
          var url = $(jsEvent.target).closest('.calendar-init').data('url-select');
          App.ajax("POST", url, data, {
            reloadUniform: true,
            reloadTimepicker: true,
            reloadDatepicker: true,
            ajaxSuccess : function(data, status, xhr) {
              initModalEvent();
            }
          });
        }
      },
      loading: function(isLoading, view) {
        if(isLoading){
          App.blockUI(this);
        } else {
          App.unblockUI(this);
        }
      }
    });

  };

  var eventSourceSelection = function(){
    function format(es){
      if (!es.id) return es.text; // optgroup
      return '<span class="simplecolorpicker"><span class="color" style="background-color: ' + $(es.element).data("color") + '"></span></span>' + es.text;
    }
    $("#calendar_event_calendar_event_source_id").select2({
      formatResult: format,
      formatSelection: format,
      escapeMarkup: function (m) {
        return m;
      }
    });
    $("#calendar_event_calendar_event_source_id").on('change', function(e){
      var url = $(this).data("url-callback");
      var id = e.val;
      App.ajax("GET", url, { id: id }, {
        elementToBlock: '#form-calendar-event',
        ajaxSuccess : function(data, status, xhr) {
          data = JSON.parse(data);
          $('#calendar_event_study_source_id').empty();
          $('#calendar_event_study_source_id').append($('<option>').attr('value', ""));
          $('#calendar_event_study_source_id').select2('data', null);
          $.each(data, function(i, value) {
            $('#calendar_event_study_source_id').append($('<option>').text(value.title).attr('value', value.id));
          });
        }
      });
    });

    $("#calendar_event_study_source_id").select2();
  };


  var initSchedule = function() {

    function updateRequiredFields(){
      $('input, select', '.event_option').removeClass('required');
      $('input, select', '.event_option').not(':hidden').addClass('required');
    }

    var toggle_repeats_yearly_on = function(){
      if($('#calendar_event_repeats_yearly_on').is(':checked')){
        $('#event_repeats_yearly_on_options').show();
      } else {
        $('#event_repeats_yearly_on_options').hide();
      }

      updateRequiredFields();
    };
    toggle_repeats_yearly_on();
    $('#calendar_event_repeats_yearly_on').on('change',function(){
      toggle_repeats_yearly_on();
    });
    var toggle_event_times = function(){
      $('.event_time').show();
    };
    toggle_event_times();
    var toggle_event_options = function(selected){
      $('.event_option').hide();
      switch (selected)
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
      };

      updateRequiredFields();
    };
    toggle_event_options($('input[name="calendar_event[repeats]"]:checked').val());
    $('input[name="calendar_event[repeats]"]').on('change',function(){
      toggle_event_options($(this).val());
    });
    var toggle_repeat_ends = function(selected){
      switch (selected)
      {
        case 'never':
          $('#event_repeat_ends_on').hide();
        $('#event_repeat_ends_count').hide();
        break;
        case 'on':
          $('#event_repeat_ends_on').show();
        $('#event_repeat_ends_count').hide();
        break;
        case 'count':
          $('#event_repeat_ends_count').show();
        $('#event_repeat_ends_on').hide();
        break;
      }
      updateRequiredFields();
    };
    toggle_repeat_ends($('select[name="calendar_event[repeat_ends]"]').val());
    $('select[name="calendar_event[repeat_ends]"]').on('change',function(){
      toggle_repeat_ends($(this).val());
    });
    var toggle_repeats_monthly = function(selected){
      switch (selected)
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
      updateRequiredFields();
    };
    toggle_repeats_monthly($('select[name="calendar_event[repeats_monthly]"]').val());
    $('select[name="calendar_event[repeats_monthly]"]').on('change',function(){
      toggle_repeats_monthly($(this).val());
    });

    function addRevisionEventsValidationRules(){
      $('#spaced-revision-block input').not(':hidden').addClass('required');

      $('#spaced-revision-block input[name$="[to_time]"]').each(function(i, ele){
        fromTimeElementName = $(ele).attr('name').replace('to_time', 'from_time');
        $(ele).rules( "add", {
          timeGreaterThan: fromTimeElementName,
          messages: {
            timeGreaterThan: 'Deve ser maior que o horário inicial.'
          }
        });
      });
    }

    $("#use-spaced-revision").on('click', function(e){
      if($(this).is(':checked')) {
        $("#spaced-revision-block").show();
        addRevisionEventsValidationRules();
      } else {
        $('#spaced-revision-block input').not(':hidden').removeClass('required');
        $('#spaced-revision-block input').each(function(i, ele){
          $(ele).rules('remove');
        });
        $("#spaced-revision-block").hide();
      }

    });

    $(document).on('nested:fieldAdded:revision_events', function(event){
      App.initDatePickers();
      App.initTimePickers();
      addRevisionEventsValidationRules();
    })
  };

  var handleFormValidation = function(){

    var form = $('#form-calendar-event');
    var error = $('.alert-error', form);

    validator = form.validate({
      doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
        errorElement: 'span', //default input error message container
      errorClass: 'help-block', // default input error message class
      focusInvalid: false, // do not focus the last invalid input
      ignore: [],
      rules: {
        'calendar_event[calendar_event_source_id]': {
          required: true
        },
        "calendar_event[to_time]": {
          timeGreaterThan: 'calendar_event[from_time]'
        }
      },

      messages: {
        "calendar_event[to_time]": {
          timeGreaterThan: 'Deve ser maior que o horário inicial.'
        }
      },

      errorPlacement: function (error, element) {
        $(element).closest('.controls').append(error);
      },

      invalidHandler: function (event, validator) { //display error alert on form submit   
        error.show();
        App.scrollTo(error, -200);
      },

      highlight: function (element) { // hightlight error inputs
        $(element)
        .closest('.help-inline').removeClass('ok'); // display OK icon
        $(element)
        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
      },

      unhighlight: function (element) { // revert the change done by hightlight
        $(element)
        .closest('.control-group').removeClass('error'); // set error class to the control group
      },

      success: function (label) {
      },

      submitHandler: function (form) {
        error.hide();

        var url = $(form).attr('action');

        App.ajax("POST", url, $(form).serialize(), {
          elementToBlock : form,
          ajaxSuccess: function(evt, data, status, xhr){
          }
        });
      }

    });
  };

  var initModalEvent = function() {
    eventSourceSelection();
    initSchedule();
    handleFormValidation();
  };

  var new_event = function() {
    //Moving the element (with append) to the top left of the calendar
    $('.fc-header-left').append($("#calendar-options"));

    $(".new-event").on('click', function(e){
      e.preventDefault();

      var url = this.href;
      App.ajax("GET", url, {}, {
        reloadUniform: true,
        reloadTimepicker: true,
        reloadDatepicker: true,
        ajaxSuccess : function(data, status, xhr) {
          initModalEvent();
        }
      });

    });

  };


  var remove_event = function() {
    App.ajaxRailsUJS("#remove-event", {
    });
  };

  var timetables = function(){
    App.ajaxRailsUJS(".activate-timetable", {
    });
  };

  return {
    //main function to initiate the module
    init: function () {
      initCalendar();
      new_event();
      remove_event();
      timetables();
    }


  };

}();
