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
