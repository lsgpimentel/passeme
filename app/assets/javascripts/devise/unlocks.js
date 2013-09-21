//= require jquery-validation/dist/jquery.validate.min
//= require select2/select2.min
//= require_self

jQuery(document).ready(function() {
  UnlockPassword.init();
});


var UnlockPassword = function () {

  var handleUnlockPassword = function () {
    $('#unlock-form').validate({
      errorElement: 'label', //default input error message container
      errorClass: 'help-inline', // default input error message class
      focuiInvalid: false, // do not focus the last invalid input
      ignore: "",
      rules: {
        "user[email]": {
          required: true,
          email: true
        }
      },

      messages: {
        "user[email]": {
          required: "Email is required."
        }
      },

      invalidHandler: function (event, validator) { //display error alert on form submit   

      },

      highlight: function (element) { // hightlight error inputs
        $(element)
        .closest('.control-group').addClass('error'); // set error class to the control group
      },

      success: function (label) {
        label.closest('.control-group').removeClass('error');
        label.remove();
      },

      errorPlacement: function (error, element) {
        error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
      },

      submitHandler: function (form) {
        form.submit();
      }
    });

    $('#unlock-form input').keypress(function (e) {
      if (e.which == 13) {
        if ($('#unlock-form').validate().form()) {
          $('#unlock-form').submit();
        }
        return false;
      }
    });

    jQuery('#back-btn').click(function () {
    });

  }

  return {
    //main function to initiate the module
    init: function () {
      handleUnlockPassword();
    }
  };

}();
