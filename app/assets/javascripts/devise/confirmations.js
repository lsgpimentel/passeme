jQuery(document).ready(function() {
  ResendEmailConfirmation.init();
});

var ResendEmailConfirmation = function () {

  var handleResendEmailConfirmation = function () {
    $('.confirmation-form').validate({
      errorElement: 'label', //default input error message container
      errorClass: 'help-inline', // default input error message class
      focusInvalid: false, // do not focus the last invalid input
      ignore: "",
      rules: {
        "user[email]": {
          required: true,
          email: true
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

    $('.confirmation-form input').keypress(function (e) {
      if (e.which == 13) {
        if ($('.confirmation-form').validate().form()) {
          $('.confirmation-form').submit();
        }
        return false;
      }
    });

    jQuery('#forget-password').click(function () {
    });


  };

  return {
    //main function to initiate the module
    init: function () {
      handleResendEmailConfirmation();
    }

  };

}();

