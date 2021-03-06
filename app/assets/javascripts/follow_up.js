var FollowUp = function () {
  var startDate, endDate;

  var initTables = function(){
    App.initDatatablesBootstrapIntegration();

    if (!jQuery().dataTable) {
      return;
    }

    $('#table-events-to-study').dataTable({
      "aoColumns": [
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": false }
      ],
      "aLengthMenu": [
        [20, 50, 100, -1],
        [20, 50, 100, "All"] // change per page values here
      ]
    });
    jQuery('#table-events-to-study_wrapper .dataTables_filter input').addClass("m-wrap medium"); // modify table search input
    jQuery('#table-events-to-study_wrapper .dataTables_length select').addClass("m-wrap small"); // modify table per page dropdown
    jQuery('#table-events-to-study_wrapper .dataTables_length select').select2(); // initialize select2 dropdown

    $('#table-events-studied-with-debt').dataTable({
      "aoColumns": [
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": true }
      ],
      "aLengthMenu": [
        [20, 50, 100, -1],
        [20, 50, 100, "All"] // change per page values here
      ]
    });
    jQuery('#table-events-studied-with-debt_wrapper .dataTables_filter input').addClass("m-wrap medium"); // modify table search input
    jQuery('#table-events-studied-with-debt_wrapper .dataTables_length select').addClass("m-wrap small"); // modify table per page dropdown
    jQuery('#table-events-studied-with-debt_wrapper .dataTables_length select').select2(); // initialize select2 dropdown

    $('#table-events-studied').dataTable({
      "aoColumns": [
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": true }
      ],
      "aLengthMenu": [
        [20, 50, 100, -1],
        [20, 50, 100, "All"] // change per page values here
      ]
    });
    jQuery('#table-events-studied_wrapper .dataTables_filter input').addClass("m-wrap medium"); // modify table search input
    jQuery('#table-events-studied_wrapper .dataTables_length select').addClass("m-wrap small"); // modify table per page dropdown
    jQuery('#table-events-studied_wrapper .dataTables_length select').select2(); // initialize select2 dropdown

  };

  var initFollowUpDaterange = function () {

    $('#follow-up-date-range').daterangepicker({
      ranges: {
        'Hoje': [moment(), moment()],
        'Ontem': [moment().subtract('days', 1), moment().subtract('days', 1)],
        'Últimos 7 Dias': [moment().subtract('days', 6), moment()],
        'Últimos 30 Dias': [moment().subtract('days', 29), moment()],
        'Este Mês': [moment().startOf('month'), moment().endOf('month')],
        'Mês Passado': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
        //'Today': [moment(), moment()],
        //'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
        //'Last 7 Days': [moment().subtract('days', 6), moment()],
        //'Last 30 Days': [moment().subtract('days', 29), moment()],
        //'This Month': [moment().startOf('month'), moment().endOf('month')],
        //'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
      },
      opens: 'right',
      format: 'DD/MM/YYYY',
      separator: ' até ',
      //separator: ' to ',
      startDate: moment().subtract('months', 1),
      endDate: moment(),
      locale: {
        applyLabel: 'Alterar',
        cancelLabel: 'Cancelar',
        fromLabel: 'De',
        toLabel: 'Até',
        customRangeLabel: 'Intervalo Customizado',
        daysOfWeek: ["Do", "Se", "Te", "Qu", "Qu", "Se", "Sa"],
        monthNames: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"],
        //applyLabel: 'Submit',
        //fromLabel: 'From',
        //toLabel: 'To',
        //customRangeLabel: 'Custom Range',
        //daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
        //monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        firstDay: 1
      },
      showWeekNumbers: true,
      cancelClass: '',
      applyClass: ''
    },

    function (start, end) {
      FollowUp.refreshContent(start, end);
    });

    $('#follow-up-date-range span').html(moment().subtract('months', 1).format('D [de] MMMM [de] YYYY') + ' - ' + moment().format('D [de] MMMM [de] YYYY'));
  };

  var completeEvent = function(){
    $("#table-events-to-study").on('click', '.btn.complete', function(e){
      e.preventDefault();

      url = $(this).closest('form').attr('action');
      App.ajax('GET', url, {}, {
        reloadUniform : true,
        reloadTimepicker : true,
        ajaxSuccess : function(data, status, xhr) {
          init();
        },
      });
    });


    var init = function(){
      $("input[name=studied-all]").on('click', function(evt){
        var showDebtReason = $(evt.target).val() == 0;
        if(showDebtReason){
          $(".debt-item").show();
        } else {
          $(".debt-item").hide();
        }
      });

      handleFormValidation();
    };

    var handleFormValidation = function(){

      var form = $('#form-complete-event');
      var error = $('.alert-error', form);

      validator = form.validate({
        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
          errorElement: 'span', //default input error message container
        errorClass: 'help-inline', // default input error message class
        focusInvalid: false, // do not focus the last invalid input
        rules: {
          "studied-all": {
            required: true
          }
        },

        messages: { // custom messages for radio buttons and checkboxes
        },

        errorPlacement: function (error, element) {
          if (element.attr("name") == "studied-all" || element.attr("name") == 'follow_up_item[studied_time]') {
            $(element).closest('.controls').append(error.addClass("no-left-padding"));
          } else {
            error.insertAfter(element);
          }
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
  };

  return {

    //main function
    init: function () {
      initFollowUpDaterange();
      initTables();
      completeEvent();
    },
    refreshContent: function(start, end) {
      var url = $('#follow-up-date-range').data('url-callback');
      if(start !== undefined && end !== undefined) {
        startDate = start.format('X');
        endDate = end.format('X');
      }
      data = {start: startDate, end: endDate};

      App.ajax("GET", url, data, {
        ajaxSuccess: function(evt, data, status, xhr){
          initTables();
          completeEvent();
        }
      });

    }

  };

}();
