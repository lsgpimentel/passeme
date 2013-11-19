var SubjectGroups = function () {

  var sortable_portlet = function() {
    if (!jQuery().sortable) {
      return;
    }

    $(".column").sortable({
      connectWith: ".column",
      opacity: 0.8,
      coneHelperSize: true,
      placeholder: 'sortable-box-placeholder round-all',
      forcePlaceholderSize: true,
      tolerance: "pointer"
    });

    $(".portlet-title").disableSelection();
  };

  var sortable_subjects = function() {

    $(".sortable-itens").sortable({
      connectWith: ".sortable-itens",
      opacity: 0.8,
      coneHelperSize: true,
      placeholder: 'sortable-box-placeholder round-all',
      forcePlaceholderSize: true,
      tolerance: "pointer"
    });

    var updateSortableCallback = function(event, ui) {
      var $ulDest = ui.item.closest('ul');
      var $ulSender = ui.sender;
      
      var sgBox = ui.item.closest('.subject-group-box')[0];
      var availableBox = ui.item.closest('#available-subjects-box')[0];
      var newSubjectGroupBox = ui.item.closest('#new-subject-group-box')[0];
      
      var url = "<%= subject_group_update_subject_path %>";
	  var idGroup = null;
	  var idSubject = ui.item.children('.subject-id').val();
	  
      if(sgBox !== undefined) {
    	  idGroup = sgBox.children('.subject-group-id').val();
      } else if (availableBox !== undefined) {
      } else if(newSubjectGroupBox !== undefined) {
    	  
      }
      
	  App.ajax("POST", url, {
		  "subject_group_id": idGroup,
		  "subject_id": idSubject
		  }
	  );
	  
      toggleEmptyClass($ulDest);
      toggleEmptyClass($ulSender);

      function toggleEmptyClass(elem){
        if($(elem).children().length > 0){
          $(elem).removeClass('sortable-box-placeholder empty');
        } else {
          $(elem).addClass('sortable-box-placeholder empty');
        }
      }
    };

    $( ".sortable-itens" ).on("sortupdate", updateSortableCallback );
    $( ".sortable-itens" ).disableSelection();
  };

  var new_subject_group = function(){
    App.ajaxRailsUJS('form#new-subject-group', {
      reloadUniform: false,
      ajaxComplete : function(xhr, status) {
        console.log('complete! -> ' + status);
      }
    });

  };

  // var updateOutput = function (e) {
  //   var list = e.length ? e : $(e.target),
  //   output = list.data('output');
  //   if (window.JSON) {
  //     output.val(window.JSON.stringify(list.nestable('serialize'))); //, null, 2));
  //   } else {
  //     output.val('JSON browser support required for this demo.');
  //   }
  // };


  return {
    //main function to initiate the module
    init: function () {
      sortable_portlet();
      sortable_subjects();
      new_subject_group();
    }

  };

}();

