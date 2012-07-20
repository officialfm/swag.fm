// ===============
// App settings //
// ===============

var settings = {
  siteUrl: 'http://0.0.0.0:3000'
};

// ==========
// Actions //
// ==========

function bookmark(url, tabId) {
  $.ajax({
    url: settings.siteUrl + '/players.json',
    dataType: 'json',
    type: 'POST',
    data: {player: {url: url}},
    success: function() { setBookmarkIcon(tabId); }
  });
};

function getBookmark(url, options) {
  $.ajax({
    url: settings.siteUrl + '/players.json',
    dataType: 'json',
    data: { url: url },
    success: options.success
  });
};

function unBookmark(playerId, tabId) {
  $.ajax({
    url: settings.siteUrl + '/players/' + playerId + '.json',
    dataType: 'json',
    type: 'DELETE',
    success: function() { resetBookmarkIcon(tabId); }
  });
};

// =========
// Events //
// =========

function iconClicked(tab) {
  getBookmark(tab.url, {
    success: function(players) {
      if (players.length > 0) unBookmark(players[0].id, tab.id);
      else bookmark(tab.url, tab.id);
    }
  })
};

// =================
// Helper methods //
// =================

function checkForValidUrl(tabId, changeInfo, tab) {
  if (tab.url.match(/official\.fm\/[playlists|tracks]/)) {
    getBookmark(tab.url, {
      success: function(players) {
        if (players.length > 0) setBookmarkIcon(tabId);
        chrome.pageAction.show(tabId);
      }
    });
  }
};

function setBookmarkIcon(tabId) {
  chrome.pageAction.setIcon({tabId: tabId, path: 'icon_bookmarked.ico'});
};

function resetBookmarkIcon(tabId) {
  chrome.pageAction.setIcon({tabId: tabId, path: 'icon.ico'});
};

// ======================
// Bind browser events //
// ======================

chrome.tabs.onUpdated.addListener(checkForValidUrl);
chrome.pageAction.onClicked.addListener(iconClicked);
