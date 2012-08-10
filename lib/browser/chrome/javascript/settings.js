SwagFm.Settings = function() {};

$.extend(SwagFm.Settings, {

  password: function() {
    return localStorage['password'];
  },

  login: function() {
    return localStorage['login'];
  },

  setPassword: function(password) {
    localStorage['password'] = password;
  },

  setLogin: function(login) {
    localStorage['login'] = login;
  }
});