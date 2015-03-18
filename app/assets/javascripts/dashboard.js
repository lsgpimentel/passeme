var Dashboard = function () {


  var makeTourButton = function(){
    $('#make-tour').on('click', function(){
      Tours.dashboard();
    });
  };

  return {
    init: function () {
      makeTourButton();
    }
  };

}();

