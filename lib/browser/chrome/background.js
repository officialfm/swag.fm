// ===============
// App settings //
// ===============

var settings = {
  siteUrl: 'http://0.0.0.0:3000'
};

// ==========
// Actions //
// ==========

function bookmark(tab) {
  $.ajax({
    url: settings.siteUrl + '/players.json',
    dataType: 'json',
    type: 'POST',
    data: {player: {url: tab.url}},
    success: function() { setBookmarkedIcon(tab.id); }
  });
};

function checkBookmarkedState(tab, options) {
  $.ajax({
    url: settings.siteUrl + '/players/bookmark',
    dataType: 'json',
    data: { url: tab.url },
    success: options.success
  });
};

// =================
// Helper methods //
// =================

function checkForValidUrl(tabId, changeInfo, tab) {
  if (tab.url.match(/official\.fm\/[playlists|tracks]/)) {
    checkBookmarkedState(tab, {success: function(players) {
      if (players) setBookmarkedIcon(tabId);
      chrome.pageAction.show(tabId);
    }});
  }
};

function setBookmarkedIcon(tabId) {
  chrome.pageAction.setIcon({tabId: tabId, path: 'icon_bookmarked.ico'});
};

// ======================
// Bind browser events //
// ======================

chrome.tabs.onUpdated.addListener(checkForValidUrl);
chrome.pageAction.onClicked.addListener(bookmark);
