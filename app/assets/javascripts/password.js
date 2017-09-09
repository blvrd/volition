$(document).on('turbolinks:load', function() {
  if ($('body').hasClass('users-new')) {
    $('#registration_password').focus(function(e) {
      $('.passwordRules').removeClass('hidden')
    })

    $('#registration_password').keyup(function(e) {
      var password = e.target.value

      var passedRules = checkPasswordRules(password)
      console.log(passedRules)
      var allRulesPassed = markPassedRules(passedRules)

      if (allRulesPassed) {
        $('input[type="submit"]').prop('disabled', false)
      } else {
        $('input[type="submit"]').prop('disabled', true)
      }
    })

    function markPassedRules(passedRules) {
      $('.checkMark').addClass('xMark').removeClass('checkMark')
      var ruleListItems = $('.passwordRules li')

      passedRules.forEach(function(passedRule) {
        $(ruleListItems[passedRule]).find('.xMark').removeClass('.xMark').addClass('checkMark')
      })

      if (passedRules.filter(function(rule) { return rule !== undefined }).length == ruleListItems.length) {
        return true
      } else {
        return false
      }
    }

    function checkPasswordRules(password) {
      rules = [
        checkLength,
        checkTop100,
        ensureDoesntMatchEmail
      ]

      return rules.map(function(rule, index) {
        result = rule(password)

        if (result == true) {
          return index
        }
      })
    }

    function checkLength(password) {
      return password.length >= 10
    }

    function checkTop100(password) {
      if (!window.top100) {
        getTop100().then(function() {
          return !window.top100.includes(password)
        })
      } else {
        return !window.top100.includes(password)
      }

    }

    function getTop100() {
      return $.ajax({
        url: 'https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/10_million_password_list_top_100.txt'
      }).then(function(data) {
        window.top100 = data
      })
    }

    function ensureDoesntMatchEmail(password) {
      return $('#user_email').val() != password
    }
  }
})
