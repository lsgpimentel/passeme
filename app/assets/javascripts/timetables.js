var Timetables = function () {




  var initStudyTimeStep = function(){

    var addTimeToList = function (studyTime) {

      var getProductivityStars = function(n){
        var html = '';
        for(i=0; i<n; i++){
          html += '<div class="star-rating star-rating-hover"></div>';
        }
        return html;

      };

      var lastEle = $("#study-times > .study-time").last();
      var id = 0;
      if(lastEle.length > 0) {
        id = parseInt(lastEle.attr('id').replace('study-time-', '')) + 1;
      }


      var studyTimeDiv = $('<div id="study-time-' + id + '" class="study-time"></div>');
      $("#study-times").append(studyTimeDiv);

      $.each(studyTime, function(i, n){
        $('<input type="hidden">').attr({
          name: 'timetable[study_times_attributes][' + id + '][' + i + ']',
          value: n
        }).appendTo($(studyTimeDiv));
      });


      //--//
      var title = studyTime.from + " - " + studyTime.to;

      var td;
      $(".time-table th").each(function(i, n){
        if($(n).data("day") == studyTime.day) {
          td = $(n).closest("table").find('td')[getSiblingNumber($(n))];
          return false;
        }
      });

      var html = $('<div class="icon-btn span12 study-item" data-study-time="' + id + '">' +
                   '<p>' + title + '</p>' +
                   '<a class="remove-study-time"><span class="badge badge-important"><i class="icon-remove"></i></span></a>' +
                   '</div>');

      $('.remove-study-time', html).on('click', function(){
        var si = $(this).closest('.study-item');
        var fieldId = $(si).data('study-time');

        $(si).popover('destroy');

        $(si).remove();
        $("#study-times > .study-time[id=study-time-" + fieldId +"]").remove();


      });

      $(html).popover({ 
        html : true,
        trigger: 'hover',
        placement: 'top',
        title: function() {
          return 'Study Time';
        },
        content: function() {
          return '<div class="info-study-time-hover">' + getProductivityStars(studyTime.productivity) + '</div>';
        }
      });

      $(td).append($(html));

      function getSiblingNumber(oElement) {
        return $(oElement).parent().children(oElement.nodeName).index(oElement);
      }

    };


    var addTimeClickEvent = function(){

      $('#add-time').on('click', function () {
        var from = $.trim($('#time-from').val());
        var to = $.trim($('#time-to').val());
        var productivity = $("input[name=productivity]:checked").val();
        var days = $("#days").val();

        if(from != '' && to != '' && productivity > 0 && days.length > 0) {

          $.each(days, function(i,n){
            var studyTime = {
              day: n,
              from: from,
              to: to,
              productivity: productivity
            };
            addTimeToList(studyTime);
          });

          $('.timepicker-24').timepicker('clear');
          $("#days").select2('data', null);
          $("input[name=productivity]").prop('checked', false);
        }
      });
    };


    var loadTimes = function(){
      //predefined events
      $('#study-times').html("");
      var days = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
      for(var i=0; i<100; i++) {
        var studyTime = {
          day: days[Math.floor(Math.random()*days.length)],
          from: "15:10",
          to: "15:20",
          productivity: 5
        };
        addTimeToList(studyTime);
      }
    };


    var initOptionsBlock = function(){
      $("#use-pomodoro-technique").on('change', function(){
        $("#pomodoro-technique-block").toggle();

      });
      $("#use-spaced-repetition").on('change', function(){
        $("#spaced-repetition-block").toggle();
      });
    };

    $('#days').select2({
      placeholder: "Select the days",
      allowClear: true,
      closeOnSelect: false
    });

    //loadTimes();
    addTimeClickEvent();
    initOptionsBlock();
  };

  var initStudySourcesStep = function() {
    $('#subjects-select').multiSelect({
      selectableOptgroup: true
    });
  };

  var initWizard = function() {

    var form = $('#form-timetable');
    var error = $('.alert-error', form);
    var success = $('.alert-success', form);

    form.validate({
      doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
      errorElement: 'span', //default input error message container
      errorClass: 'validate-inline', // default input error message class
      focusInvalid: false, // do not focus the last invalid input
      rules: {
        "timetable[name]": {
          required: true
        }
      },

      messages: { // custom messages for radio buttons and checkboxes
      },

      errorPlacement: function (error, element) { // render error placement for each input type
        error.insertAfter(element); // for other inputs, just perform default behavior
      },

      invalidHandler: function (event, validator) { //display error alert on form submit   
        success.hide();
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
        success.show();
        error.hide();
        form.submit();
        //add here some ajax code to submit your form or just call form.submit() if you want to submit the form without ajax
      }

    });

    var sendTabData = function(index){
      var url = $("#url-step-" + index).val();

      if(url != '') {
        App.ajax("POST", url, form.serialize(), {
          ajaxSuccess : function(data, status, xhr) {
          }

        });
      }

      return true;
    };

    // default form wizard
    $('#portlet-wizard-timetable').bootstrapWizard({
      'nextSelector': '.button-next',
      'previousSelector': '.button-previous',
      onTabClick: function (tab, navigation, index) {
        return false;
      },
      onNext: function (tab, navigation, index) {
        success.hide();
        error.hide();

        if (form.valid() == false) {
          return false;
        }


        if(!sendTabData(index)){
          return false;
        }

        var current = index + 1;
        var total = navigation.find('li').length;
        // set wizard title
        $('.step-title', $('#portlet-wizard-timetable')).text('Step ' + current + ' of ' + total);
        // set done steps
        jQuery('li', $('#portlet-wizard-timetable')).removeClass("done");
        var li_list = navigation.find('li');
        for (var i = 0; i < index; i++) {
          jQuery(li_list[i]).addClass("done");
        }

        if (current == 1) {
          $('#portlet-wizard-timetable').find('.button-previous').hide();
        } else {
          $('#portlet-wizard-timetable').find('.button-previous').show();
        }

        var buttonNext = $('#portlet-wizard-timetable').find('.button-next');
        if (current >= total) {
          buttonNext.hide();
          $('#portlet-wizard-timetable').find('.button-submit').show();
        } else {
          buttonNext.show();
          $('#portlet-wizard-timetable').find('.button-submit').hide();
        }

        App.scrollTo($('.page-title'));
      },
      onPrevious: function (tab, navigation, index) {
        success.hide();
        error.hide();

        var total = navigation.find('li').length;
        var current = index + 1;
        // set wizard title
        $('.step-title', $('#portlet-wizard-timetable')).text('Step ' + (index + 1) + ' of ' + total);
        // set done steps
        jQuery('li', $('#portlet-wizard-timetable')).removeClass("done");
        var li_list = navigation.find('li');
        for (var i = 0; i < index; i++) {
          jQuery(li_list[i]).addClass("done");
        }

        if (current == 1) {
          $('#portlet-wizard-timetable').find('.button-previous').hide();
        } else {
          $('#portlet-wizard-timetable').find('.button-previous').show();
        }

        if (current >= total) {
          $('#portlet-wizard-timetable').find('.button-next').hide();
          $('#portlet-wizard-timetable').find('.button-submit').show();
        } else {
          $('#portlet-wizard-timetable').find('.button-next').show();
          $('#portlet-wizard-timetable').find('.button-submit').hide();
        }

        App.scrollTo($('.page-title'));
      },
      onTabShow: function (tab, navigation, index) {
        var total = navigation.find('li').length;
        var current = index + 1;
        var $percent = (current / total) * 100;
        $('#portlet-wizard-timetable').find('.bar').css({
          width: $percent + '%'
        });
      }
    });

    $('#portlet-wizard-timetable').find('.button-previous').hide();
    $('#portlet-wizard-timetable .button-submit').on('click').hide();
  };


  return {
    init: function () {
      initStudyTimeStep();
      initStudySourcesStep();
      initWizard();
    }
  };

}();
