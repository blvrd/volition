$(document).on('turbolinks:load', function() {
  if ($('body').hasClass('payments-new')) {
    var initializeStripe = (function(e) {
      var stripe = Stripe(gon.stripe_public_key);
      var elements = stripe.elements();
      var form = document.getElementById('payment-form')

      var style = {
        base: {
          fontSize: '16px',
          lineHeight: '24px'
        }
      }

      var card = elements.create('card', {style: style})

      card.mount('#card-element')

      card.addEventListener('change', function(e) {
        var displayError = document.getElementById('card-errors');

        if (event.error) {
          displayError.textContent = event.error.message;
        } else {
          displayError.textContent = ''
        }
      })

      var stripeTokenHandler = function(token) {
        var form = document.getElementById('payment-form')
        var hiddenInput = document.createElement('input')

        hiddenInput.setAttribute('type', 'hidden')
        hiddenInput.setAttribute('name', 'stripeToken')
        hiddenInput.setAttribute('value', token.id)

        form.appendChild(hiddenInput)
        form.submit()
      }

      form.addEventListener('submit', function(e) {
        event.preventDefault()
        $(".fa-cog").removeClass("hidden")
        $(".submitButtonText").addClass("hidden")

        stripe.createToken(card).then(function(result) {
          if (result.error) {
            var errorElement = document.getElementById('card-errors')
            errorElement.textContent = result.error.message
            $(".fa-cog").addClass("hidden")
            $(".submitButtonText").removeClass("hidden")
          } else {
            stripeTokenHandler(result.token)
          }
        })
      })
    }())
  }
})
