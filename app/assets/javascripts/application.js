//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  window.swagFm = new SwagFm;
  $(window).bind('page:change', swagFm.pageChanged.bind(swagFm));
});
