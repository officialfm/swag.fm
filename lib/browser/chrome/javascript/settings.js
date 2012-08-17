SwagFm.Settings = function() {};

$.extend(SwagFm.Settings, {

  password: function() {
    return localStorage['password'];
  },

  email: function() {
    return localStorage['email'];
  },

  setPassword: function(password) {
    localStorage['password'] = password;
  },

  setEmail: function(login) {
    localStorage['email'] = login;
  },

  session: function() {
    
  }
});