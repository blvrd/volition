function onSignIn(googleUser) {
  var token = googleUser.getAuthResponse().id_token

  if (token !== null) {
    document.getElementById('google_id_token').value = token

    if (document.getElementById('google_signin')) {
      document.getElementById('google_signin').submit()
    } else {
      $('.google_signin').submit()
    }

    gapi.auth2.getAuthInstance().signOut()
  }
}

function setGoogleButtonText() {
  var $span  = $("span:contains('Sign in with Google'):not('.abcRioButtonContents')")
  var path   = window.location.pathname
  var action = path === "/users/new" ? "Sign up" : "Log in"
  $span.text(action + " with Google")
}

$(document).on('turbolinks:load', function() {
  if ($('body').hasClass('sessions-new')) {
    setTimeout(setGoogleButtonText, 100)
    ShowPassword.config.color = "#666"
    ShowPassword.initialize()
  }
})
