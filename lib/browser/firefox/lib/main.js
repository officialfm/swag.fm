// ===============
// App settings //
// ===============

var settings = {
  siteUrl: 'http://0.0.0.0:3000'
};

const Widget = require("widget").Widget;
const Tabs = require("tabs");
const Request = require("request").Request;
const data = require("self").data;
const Awesomebar = require('awesomebar').Awesomebar;
var widget;

// ==========
// Actions //
// ==========

function bookmark(url, options) {
  Request({
    url: settings.siteUrl + '/players.json',
    content: {player: {url: url}},
    onComplete: _bookmarkResponse
  }).post();
};

function _bookmarkResponse(response) {
  if (response.status == 200) {
    setBookmarkIcon();
    reloadSite();
  }
};

function getBookmark(url, options) {
  Request({
    url: settings.siteUrl + '/players.json',
    content: {url: url},
    onComplete: function(response) { _getBookmarkResponse(response, options); }
  }).get();
};

function _getBookmarkResponse(response, options) {
  if (response.status == 200 && options)
    options.success(response.json);
};

function unBookmark(playerId) {
  Request({
    url: settings.siteUrl + '/players/' + playerId + '.json',
    content: {_method: 'delete'},
    onComplete: _unBookmarkResponse
  }).post();
};

function _unBookmarkResponse(response) {
  if (response.status == 200) {
    resetBookmarkIcon();
    reloadSite();
  }
};

// =========
// Events //
// =========

function iconClicked() {
  getBookmark(Tabs.activeTab.url, {
    success: function(players) {
      if (players.length > 0) unBookmark(players[0].id);
      else bookmark(Tabs.activeTab.url);
    }
  });
};

// =================
// Helper methods //
// =================

function checkForValidUrl(tab) {
  console.log('check');
  if (tab.url.match(/official\.fm\/tracks/)) {
    getBookmark(tab.url, {
      success: function(players) {
        addIcon(players.length > 0);
      }
    });
  } else removeIcon();


  //TODO: change
  Awesomebar();
};

function setBookmarkIcon() {
  widget.contentURL = data.url('icon_bookmarked.ico');
};

function resetBookmarkIcon() {
  widget.contentURL = data.url('icon.ico');
};

function reloadSite() {
  for (var i in Tabs) {
    var tab = Tabs[i];
    if (tab.url.indexOf(settings.siteUrl) != -1) tab.reload();
  }
};

function addIcon(active) {
  if (widget)
    active ? setBookmarkIcon() : resetBookmarkIcon();
  else {
    widget = Widget({
      id: "mozilla-link",
      label: "Mozilla website",
      contentURL: data.url('icon' + (active ? '.ico' : '_bookmarked.ico')),
      onClick: iconClicked
    });
  }
};

function removeIcon() {
  if (widget) {
    widget.destroy();
    widget = null;
  }
};

// ======================
// Bind browser events //
// ======================

Tabs.on('activate', checkForValidUrl);
Tabs.on('ready', checkForValidUrl);
Tabs.on('open', checkForValidUrl);
