//= require jquery
//= require jquery-migrate-1.2.1.min
//= require bootstrap
//= require back-to-top
//= require bxslider/jquery.bxslider
//= require fancybox/source/jquery.fancybox.pack
//= require bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min
//= require revolution_slider/rs-plugin/js/jquery.themepunch.plugins.min
//= require revolution_slider/rs-plugin/js/jquery.themepunch.revolution.min
//= require turbolinks
//= require static_pages/app
//= require_self

jQuery(document).ready(function() {
  App.init();    
  App.initBxSlider();
  Index.initRevolutionSlider();
});
