
jQuery(document).ready(function() {
	Login.init();
});

var Login = function () {

	var handleLogin = function() {
		$('#login-form').validate({
	            errorElement: 'label', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            rules: {
	                "user[email]": {
	                    required: true
	                },
	                "user[password]": {
	                    required: true
	                },
	                "user[remember_me]": {
	                    required: false
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

	        $('#login-form input').keypress(function (e) {
	            if (e.which == 13) {
	                if ($('#login-form').validate().form()) {
	                    $('#login-form').submit();
	                }
	                return false;
	            }
	        });
	};

    
    return {
        //main function to initiate the module
        init: function () {
            handleLogin();
        }

    };

}();
