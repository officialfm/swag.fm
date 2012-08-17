// ===============
// App settings //
// ===============

SwagFm.Options = function() {
  this.initialize();
};

$.extend(SwagFm.Options.prototype, {

  initialize: function() {
    this.passwordField = $('#password');
    this.emailField = $('#email');
    this.submitButton = $('#submit');
    this.initValues();
    this.delegateEvents();
  },

  delegateEvents: function() {
    this.submitButton.click(this.save.bind(this));
  },

  initValues: function() {
    this.passwordField.val(SwagFm.Settings.password());
    this.emailField.val(SwagFm.Settings.email());
  },

  save: function() {
    SwagFm.Settings.setEmail(this.emailField.val());
    SwagFm.Settings.setPassword(this.passwordField.val());
    SwagFm.Client.login(SwagFm.Settings.email(), SwagFm.Settings.password(), {
      success: this.saveSuccess.bind(this), 
      error: this.saveError.bind(this)
    });
  },

  saveSuccess: function(a, e, i) {
    console.log(i.getAllResponseHeaders());
  },

  saveError: function() {
    alert('error!!')
  }
});

$(document).ready(function() {
  window.Settings = new SwagFm.Options();
});
