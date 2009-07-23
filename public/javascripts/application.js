// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  // sets up the hover image for activity feed items  
  $(".imgHoverMarker").tooltip({
  showURL: false,
  bodyHandler: function() {
    var i = $(this).children()[0]
    var imgsrc = $(i).attr('src');
    return $('<img src="'+imgsrc+'" />');
  }
  });

  $('input,textarea').focus( function() {
  $(this).css('border-color', '#006699');
  });
  $('input,textarea').blur( function() {
  $(this).css('border-color','#ccc');
  });

  // facebox popups
  jQuery('a[rel*=facebox]').facebox();
  
  // Subnav search box label position
  jQuery('#subnav form dt:first').css({position: 'absolute', left: '1.5em'});
  jQuery('#txtSearch:first').focus(function() { jQuery('#subnav form dt:first').css({left: '-1000em'}) });
  jQuery('#txtSearch:first').blur(function() { jQuery('#subnav form dt:first').css({left: '1.5em'}) });

});