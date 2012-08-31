// =========
// Events //
// =========

function iconClicked(tab) {
  SwagFm.Client.getBoormarks(tab.url, {
    success: function(tracks) {
      if (tracks.length > 0) unBookmark(tracks[0].id, tab.id);
      else bookmark(tab);
    }
  });
};

function unBookmark(trackId, tabId) {
  SwagFm.Client.unBookmark(trackId, {
    success: function() {
      resetBookmarkIcon(tabId);
      reloadSite();
    }
  });
};

function bookmark(tab) {
  SwagFm.Client.bookmark(tab.url, {
    success: function() { 
      setBookmarkIcon(tab.id);
      reloadSite();
    }
  });
};

// =================
// Helper methods //
// =================

function checkForValidUrl(tabId, changeInfo, tab) {
  if (tab.url.match(/official\.fm\/tracks/)) {
    SwagFm.Client.getBoormarks(tab.url, {
      success: function(tracks) {
        if (tracks.length > 0) setBookmarkIcon(tabId);
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

function reloadSite() {
  chrome.tabs.query({url: SwagFm.options.siteUrl + '/*'}, function(tabs) {
    for (i in tabs) chrome.tabs.reload(tabs[i].id);
  });
};

// ======================
// Bind browser events //
// ======================

chrome.tabs.onUpdated.addListener(checkForValidUrl);
chrome.pageAction.onClicked.addListener(iconClicked);

SwagFm.Client.initOauth();
if(!SwagFm.Client.oauth.hasToken()) SwagFm.Client.oauth.authorize();
