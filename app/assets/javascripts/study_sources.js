var StudySources = function () {

  var oTable;

  var init_table = function(){

    App.initDatatablesBootstrapIntegration();

    if (!jQuery().dataTable) {
      return;
    }

    // begin first table
    oTable = $('#table-study-sources').dataTable({
      "aoColumns": [
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": false },
        { "bSortable": false }
      ],
      "aLengthMenu": [
        [20, 50, 100, -1],
        [20, 50, 100, "All"] // change per page values here
      ],
      // set the initial value
      "iDisplayLength": 20,
      "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      "oLanguage": {
        "sLengthMenu": "_MENU_ records per page",
        "oPaginate": {
          "sPrevious": "Prev",
          "sNext": "Next"
        }
      },
      "aoColumnDefs": [{
        'bSortable': false,
        'aTargets': [0]
      }
      ]
    });

    jQuery('#table-study-sources_wrapper .dataTables_filter input').addClass("m-wrap medium"); // modify table search input
    jQuery('#table-study-sources_wrapper .dataTables_length select').addClass("m-wrap small"); // modify table per page dropdown
    jQuery('#table-study-sources_wrapper .dataTables_length select').select2(); // initialize select2 dropdown
  }


  var new_study_source = function() {
    $("#new-study-source").on('click', function(e){
      e.preventDefault();

      var url = $(this).closest('form').attr('action');
      App.ajax("GET", url, {}, {
        reloadUniform: false
      });

    });

  }

  var edit_study_source = function() {
    $('#table-study-sources .edit').on('click', function (e) {
      e.preventDefault();

      var url = $(this).closest('form').attr('action');
      App.ajax("GET", url, {}, {
        reloadUniform: false,
        ajaxSuccess: function(evt, data, status, xhr){
        }
      });

    });

  }

  var delete_study_source = function() {
    $('#table-study-sources .delete').on('click', function (e) {
      e.preventDefault();

      if(!confirm("Are you sure?")) {
        return false;
      }

      var $this = $(this);
      var data = { _method: "DELETE" };
      var url = $this.closest('form').attr('action');

      App.ajax("POST", url, data, {
        reloadUniform: false,
        ajaxSuccess: function(evt, data, status, xhr){
          var nRow = $this.parents('tr')[0];
          oTable.fnDeleteRow(nRow);
        }
      });
    });
  }


  return {
    init: function () {
      init_table();
      new_study_source();
      delete_study_source();
      edit_study_source();
    }

  };

}();
