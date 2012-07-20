// ===============
// App settings //
// ===============

var settings = {
  siteUrl: 'http://0.0.0.0:3000'
};

const widgets = require("widget");
const tabs = require("tabs");
const request = require("request").Request;
const data = require("self").data;

// ==========
// Actions //
// ==========

function bookmark(url) {
  Request({
  url: siteUrl + '/players.json',
  onComplete: function (response) {
    console.log(response);
  }});
};

// =========
// Events //
// =========

function iconClicked() {
  //console.log(arguments);
};

// ======================
// Bind browser events //
// ======================

var widget = widgets.Widget({
  id: "mozilla-link",
  label: "Mozilla website",
  contentURL: data.url("icon.ico"),
  onClick: iconClicked
});


