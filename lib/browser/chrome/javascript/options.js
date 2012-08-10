// ===============
// App settings //
// ===============

SwagFm.Options = function() {
  this.initialize();
};

$.extend(SwagFm.Options.prototype, {

  initialize: function() {
    this.passwordField = $('#password');
    this.loginField = $('#login');
    this.submitButton = $('#submit');
    this.delegateEvents();
  },

  delegateEvents: function() {
    this.submitButton.click(this.save.bind(this));
  },

  password: function() {
    return this.passwordField.val();
  },

  login: function() {
    return this.loginField.val();
  },

  save: function() {
    SwagFm.Settings.setLogin(this.login());
    SwagFm.Settings.setPassword(this.password());
  }
});

$(document).ready(function() {
  window.Settings = new SwagFm.Options();
});
