var Tasks = function () {

  var elementToBlockInAjax = function(ele){
    return ele.closest(".portlet");
  };

  var toggle_done = function() {
    $('.task-list').on('change', 'input.liChild', function() {
      var url = $(this).data('url');
      var data = { _method: "PUT" };

      App.ajax("POST", url, data, {
        elementToBlock: elementToBlockInAjax($(this))
      });
    });
  };

  var editable_due_data = function() {

    $('.due-date').editable({
      rtl : App.isRTL(),
      autotext: "never",
      url: function(params){
        var id = $(this).closest('li').attr('id').replace('task-', '');
        var url = '/tasks/' + id;
        var data = { _method: "PUT", 'task[due_in]': params.value };

        App.ajax("POST", url, data, {
          elementToBlock: elementToBlockInAjax($(this)),
          reloadUniform: false
        });
      },
      validate: function (v) {
        //if (v && v.getDate() == 10) return 'Day cant be 10!';
      },
    });
  };

  var editable_name = function() {
    $('.task-title-sp').editable({
      mode: 'inline',
      url: function(params){
        var id = $(this).closest('li').attr('id').replace('task-', '');
        var url = '/tasks/' + id;
        var data = { _method: "PUT", 'task[name]': params.value };

        App.ajax("POST", url, data, {
          elementToBlock: elementToBlockInAjax($(this)) 
        });
      },
      validate: function (value) {
        if ($.trim(value) == '') return 'This field is required';
      }
    });
  };


  var list_tasks = function(url) {
    $(".actions").on('click', '.list-tasks', function(e){
      e.preventDefault();

      App.ajax("GET", this.href, {}, {
        elementToBlock: elementToBlockInAjax($(this)),
        ajaxComplete: function(xhr, status) {
          editable_due_data();
          editable_name();
        }
      });
    });

  };

  var delete_task = function() {
    $(".task-list").on('click', '.delete-task', function(e){
      e.preventDefault();

      if(!confirm("Are you sure?")) {
        return false;
      }

      var data = { _method: "DELETE" };

      App.ajax("POST", this.href, data, {
        elementToBlock: elementToBlockInAjax($(this)),
        reloadUniform: false
      });
    });
  };

  var create_task = function() {
    $("#create-task").on('click', function(e){
      e.preventDefault();
      App.ajax("GET", this.href, {}, {
        elementToBlock: elementToBlockInAjax($(this)) 
      });

    });


  };

  return {
    //main function to initiate the module
    initDashboardWidget: function () {
      toggle_done();
      editable_due_data();
      editable_name();
      list_tasks();
      delete_task();
      create_task();
    }

  };

}();
