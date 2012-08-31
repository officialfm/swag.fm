function onLoad() {
  console.log('onload?');
  ChromeExOAuth.initCallbackPage();
};

$(document).ready(function() {
  onLoad();
});
