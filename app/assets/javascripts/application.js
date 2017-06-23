//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('.alert').delay(2000).slideUp(1500);
});
