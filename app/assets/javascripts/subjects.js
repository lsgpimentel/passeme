var Subjects = function () {

  var oTable;

  var init_table = function(){
    App.initDatatablesBootstrapIntegration();

    if (!jQuery().dataTable) {
      return;
    }

    // begin first table
    oTable = $('#table-subjects').dataTable({
      "aoColumns": [
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": false },
        { "bSortable": false },
        { "bSortable": false }
      ],
      "aLengthMenu": [
        [20, 50, 100, -1],
        [20, 50, 100, "All"] // change per page values here
      ]
    });

    jQuery('#table-subjects_wrapper .dataTables_filter input').addClass("m-wrap medium"); // modify table search input
    jQuery('#table-subjects_wrapper .dataTables_length select').addClass("m-wrap small"); // modify table per page dropdown
    jQuery('#table-subjects_wrapper .dataTables_length select').select2(); // initialize select2 dropdown
  }

  var new_subject = function() {
    $("#new-subject").on('click', function(e){
      e.preventDefault();

      var url = $(this).closest('form').attr('action');
      App.ajax("GET", url, {}, {
        reloadUniform: false
      });

    });

  }

  var view_study_sources = function() {
    $('#table-subjects .view-study-sources').on('click', function (e) {
      e.preventDefault();

      var url = $(this).closest('form').attr('action');
      App.ajax("GET", url, {}, {
        reloadUniform: false
      });

    });

  }

  var edit_subject = function() {
    $('#table-subjects .edit').on('click', function (e) {
      e.preventDefault();

      var url = $(this).closest('form').attr('action');
      App.ajax("GET", url, {}, {
        reloadUniform: false,
        ajaxSuccess: function(evt, data, status, xhr){
        }
      });

    });

  }

  var delete_subject = function() {
    $('#table-subjects .delete').on('click', function (e) {
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

    //main function to initiate the module
    init: function () {
      init_table();
      new_subject();
      delete_subject();
      edit_subject();
      view_study_sources();
    }

  };

}();

