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
    $('#table-event-sources .edit').on('click', function (e) {
      e.preventDefault();

      var url = $(this).closest('form').attr('action');
      App.ajax("GET", url, {}, {
        reloadColorpicker: true
      });

    });

  };

  var delete_event_source = function() {
    $('#table-event-sources .delete').on('click', function (e) {
      e.preventDefault();

      if(!confirm("Are you sure?")) {
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
    }

  };

}();

