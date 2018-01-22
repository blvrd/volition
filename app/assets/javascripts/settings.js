$(document).on('turbolinks:load', function() {
  if ($('body').hasClass('users-edit')) {
    var referralLink = document.getElementById("referral_link")
    var copyButton   = document.querySelector(".copyButton")

    referralLink.addEventListener("click", function(e) {
      expandLink()
      this.setSelectionRange(0, this.value.length)

      setTimeout(reset, 3000)
    })

    copyButton.addEventListener("click", function(e) {
      expandLink()
      referralLink.select()

      try {
        var successful = document.execCommand('copy');

        if (successful) {
          copyButton.disabled = true
          copyButton.innerHTML = "Copied!"

          setTimeout(reset, 3000)
        }
      } catch (err) {
          console.log('Oops, unable to copy');
      }
    })

    var reset = function() {
      copyButton.disabled = false
      copyButton.innerHTML = "Copy and send link!"
      referralLink.value = referralLink.dataset.referralCode
    }

    var expandLink = function() {
      referralLink.value = referralLink.dataset.referralLink
    }
  }
})

