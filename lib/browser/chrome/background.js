function checkForValidUrl(tabId, changeInfo, tab) {
  if (tab.url.match(/official\.fm\/[playlists|tracks]/)) {
    chrome.pageAction.show(tabId);
  }
};

chrome.tabs.onUpdated.addListener(checkForValidUrl);

chrome.pageAction.onClicked.addListener(function(tab) {
  var req = new XMLHttpRequest();
  var params = 'player[url]=' + tab.url;
  req.open('POST', 'http://0.0.0.0:3000/players', true);
  req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  req.setRequestHeader("Content-length", params.length);
  req.setRequestHeader("Connection", "close");
  req.send(params);
});
