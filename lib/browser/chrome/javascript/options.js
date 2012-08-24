function loadHandler() {
  if (SwagFm.Client.oauth.hasToken()) {
    $('#sign_in_out_div').html('<a href="options.html" onclick="chrome.extension.getBackgroundPage().closeBrowserChannel(); SwagFm.Client.oauth.clearTokens()">Sign out</a>');
    if (document.location.hash == '#just_signed_in')
      $('#just_signed_in_div').html('<p><b><font color="#00A000">Signed in. You are now ready to send links to your phone.</font></b></p>');
  } else
    $('#sign_in_out_div').html('<a href="/views/oauth.html">Sign in</a>');
}

$(document).ready(function() {
  SwagFm.Client.initOauth();
  loadHandler();
});
