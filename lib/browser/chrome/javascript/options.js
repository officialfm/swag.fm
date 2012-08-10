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
    this.initValues();
    this.delegateEvents();
  },

  delegateEvents: function() {
    this.submitButton.click(this.save.bind(this));
  },

  initValues: function() {
    this.passwordField.val(SwagFm.Settings.password());
    this.loginField.val(SwagFm.Settings.login());
  },

  save: function() {
    SwagFm.Settings.setLogin(this.loginField.val());
    SwagFm.Settings.setPassword(this.passwordField.val());
  }
});

$(document).ready(function() {
  window.Settings = new SwagFm.Options();
});
