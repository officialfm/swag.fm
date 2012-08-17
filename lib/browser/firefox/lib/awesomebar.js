"use strict";

const {Cc, Ci, Cu, Cm, components} = require('chrome');
Cu.import("resource://gre/modules/AddonManager.jsm", this);
Cu.import("resource://gre/modules/XPCOMUtils.jsm", this);

const data = require("self").data;
const windows = require("windows");

// =============
// Public API //
// =============

exports.Awesomebar = function Awesomebar(options) {
  console.log('Awesomebar!!!!!!!!!');
  addAddressBarIcon(windows.activeWindow);
};


// ==========
// Helpers //
// ==========

function addAddressBarIcon(window) {
  if (!window) return;

  let icon = window.document.createElement('image')
  icon.id = "ofm-icon";
  icon.src = 'chrome://jid1-tk1zvlzoqnphua-at-jetpack/swag_fm/data/apple-touch-icon.png';

  let urlbarIcons = window.document.getElementById('urlbar-icons');
  urlbarIcons.insertBefore(icon, urlbarIcons.firstChild);

  console.log(icon.src);

};

// =============
// Life cycle //
// =============

(function startup() {
  
})();

function shutdown(data, reason) {
  if (reason != APP_SHUTDOWN)
    unload();
};

// =================
// Window watcher //
// =================


