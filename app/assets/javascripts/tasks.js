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
          elementToBlock: elementToBlockInAjax($(this))
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
          elementToBlock: elementToBlockInAjax($(this)),
          reloadUniform: true
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
        reloadUniform: true,
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

      if(!confirm(I18n.delete_confirm_message)) {
        return false;
      }

      var data = { _method: "DELETE" };

      App.ajax("POST", this.href, data, {
        elementToBlock: elementToBlockInAjax($(this))
      });
    });
  };

  var handleFormValidation = function(){

    var form = $('#task-form');
    var error = $('.alert-error', form);

    form.validate({
      doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
        errorElement: 'span', //default input error message container
      errorClass: 'help-inline', // default input error message class
      focusInvalid: false, // do not focus the last invalid input
      rules: {
        "task[due_in]": {
          greaterThanToday: true
        }
      },

      messages: { // custom messages for radio buttons and checkboxes
        "task[due_in]": {
          greaterThanToday: "Deve ser maior que a data de hoje."
        }
      },

      errorPlacement: function (error, element) { // render error placement for each input type
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
        url = $(form).attr('action');
        App.ajax("POST", url, $(form).serialize(), {
          ajaxSuccess: function(data, status, xhr){
          }
        });
      }

    });
  }


  var create_task = function() {
    $("#create-task").on('click', function(e){
      e.preventDefault();
      App.ajax("GET", this.href, {}, {
        elementToBlock: elementToBlockInAjax($(this)),
        reloadDatepicker: true,
        ajaxSuccess : function(data, status, xhr) {
          handleFormValidation();
        }
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
      App.initUniform();
    }, updateDashboardWidget: function() {
      editable_due_data();
      editable_name();
      App.initUniform();
    }

  };

}();
