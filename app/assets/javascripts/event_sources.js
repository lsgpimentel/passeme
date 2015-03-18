var EventSources = function () {

  var oTable;

  var init_table = function(){

    App.initDatatablesBootstrapIntegration();

    if (!jQuery().dataTable) {
      return;
    }

    // begin first table
    oTable = $('#table-event-sources').dataTable({
      "aoColumns": [
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": false },
        { "bSortable": false }
      ],
      "aLengthMenu": [
        [20, 50, 100, -1],
        [20, 50, 100, "All"] // change per page values here
      ]
    });

    jQuery('#table-event-sources_wrapper .dataTables_filter input').addClass("m-wrap medium"); // modify table search input
    jQuery('#table-event-sources_wrapper .dataTables_length select').addClass("m-wrap small"); // modify table per page dropdown
    jQuery('#table-event-sources_wrapper .dataTables_length select').select2(); // initialize select2 dropdown
  };

  var handleFormValidation = function(){

    var form = $('#event-source-form');
    var error = $('.alert-error', form);

    form.validate({
      doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
        errorElement: 'span', //default input error message container
      errorClass: 'help-inline', // default input error message class
      focusInvalid: false, // do not focus the last invalid input
      ignore: [],
      rules: {
      },

      messages: { // custom messages for radio buttons and checkboxes
      },

      errorPlacement: function (error, element) { // render error placement for each input type
        if (element.attr("name") == 'calendar_event_source[color]') {
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
        App.blockUI(document.body);
        error.hide();
        form.submit();
        //add here some ajax code to submit your form or just call form.submit() if you want to submit the form without ajax
      }

    });
  }

  var new_event_source = function() {
    $("#new-event-source").on('click', function(e){
      e.preventDefault();

      var url = $(this).closest('form').attr('action');
      App.ajax("GET", url, {}, {
        reloadColorpicker: true
      });

    });

  };

  var edit_event_source = function() {
    $('#table-event-sources').on('click', '.edit', function (e) {
      e.preventDefault();

      var url = $(this).closest('form').attr('action');
      App.ajax("GET", url, {}, {
        reloadColorpicker: true
      });

    });

  };

  var delete_event_source = function() {
    $('#table-event-sources').on('click', '.delete', function (e) {
      e.preventDefault();

      if(!confirm(I18n.delete_confirm_message)) {
        return false;
      }

      var $this = $(this);
      var data = { _method: "DELETE" };
      var url = $this.closest('form').attr('action');

      App.ajax("POST", url, data, {
        ajaxSuccess: function(evt, data, status, xhr){
          var nRow = $this.parents('tr')[0];
          oTable.fnDeleteRow(nRow);
        }
      });
    });
  };


  return {
    init: function () {
      init_table();
      new_event_source();
      delete_event_source();
      edit_event_source();
    },
    initFormValidation: function() {
      handleFormValidation();
    }

  };

}();

