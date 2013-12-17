var FollowUp = function () {

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
        'Today': [moment(), moment()],
        'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
        'Last 7 Days': [moment().subtract('days', 6), moment()],
        'Last 30 Days': [moment().subtract('days', 29), moment()],
        'This Month': [moment().startOf('month'), moment().endOf('month')],
        'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
      },
      opens: (App.isRTL() ? 'right' : 'left'),
      format: 'DD/MM/YYYY',
      separator: ' to ',
      startDate: moment(),
      endDate: moment().add('months', 1),
      locale: {
        applyLabel: 'Submit',
        fromLabel: 'From',
        toLabel: 'To',
        customRangeLabel: 'Custom Range',
        daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
        monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        firstDay: 1
      },
      showWeekNumbers: true,
      cancelClass: '',
      applyClass: ''
    },

    function (start, end) {
      var url = this.element.data('url-callback');
      var data = {start: start.format('X'), end: end.format('X')};
      window.location.replace(url + '?' + $.param(data));

    });

    $('#follow-up-date-range span').html(moment().format('MMMM D, YYYY') + ' - ' + moment().add('months', 1).format('MMMM D, YYYY'));
  };

  var completeEvent = function(){
    var el = $("#table-events-to-study .btn.complete").closest("form");
    App.ajaxRailsUJS(el, {
      reloadUniform : true,
      reloadTimepicker : true,
      ajaxSuccess : function(data, status, xhr) {
        init();
      },
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
    };
  };

  return {

    //main function
    init: function () {
      initFollowUpDaterange();
      initTables();
      completeEvent();
    },


  };

}();
