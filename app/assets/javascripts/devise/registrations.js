jQuery(document).ready(function() {
	Registration.init();
});

var Registration = function () {

  var handleRegister = function () {
    $('.register-form').validate({
      errorElement: 'label', //default input error message container
      errorClass: 'help-inline', // default input error message class
      focusInvalid: false, // do not focus the last invalid input
      ignore: "",
      rules: {
        "user[email]": {
          required: true
        },
        "user[password]": {
          required: true
        },
        "user[password_confirmation]": {
          equalTo: "#user_password"
        },

        tnc: {
          required: true
        }
      },

      invalidHandler: function (event, validator) { //display error alert on form submit   

      },

      highlight: function (element) { // hightlight error inputs
        $(element).closest('.control-group').addClass('error'); // set error class to the control group
      },

      success: function (label) {
        label.closest('.control-group').removeClass('error');
        label.remove();
      },

      errorPlacement: function (error, element) {
        if (element.attr("name") == "tnc") { // insert checkbox errors after the container                  
          error.addClass('help-small no-left-padding').insertAfter($('#register_tnc_error'));
        } else if (element.closest('.input-icon').size() === 1) {
          error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
        } else {
          error.addClass('help-small no-left-padding').insertAfter(element);
        }
      },

      submitHandler: function (form) {
        form.submit();
      }
    });

    $('.register-form input').keypress(function (e) {
      if (e.which == 13) {
        if ($('.register-form').validate().form()) {
          $('.register-form').submit();
        }
        return false;
      }
    });

    // jQuery('#register-btn').click(function () {
    // });

  };

  return {
    //main function to initiate the module
    init: function () {
      handleRegister();        
    }

  };

}();
