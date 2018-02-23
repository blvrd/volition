// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require payola
//= require jquery_ujs
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require show_password/show_password
//= require_tree .

var update = React.addons.update

function aload(t){"use strict";var e="data-aload";return t=t||window.document.querySelectorAll("["+e+"]"),void 0===t.length&&(t=[t]),[].forEach.call(t,function(t){t["LINK"!==t.tagName?"src":"href"]=t.getAttribute(e),t.removeAttribute(e)}),t}

$(document).on('turbolinks:load', function() {
  aload()

  var timezone = jstz.determine()
  cookies({timezone: timezone.name()})

  $('.ratingCircle').click(function(e) {
    console.log($(this).find('.ratingNumber').text())
    $('.ratingCircle').removeClass('active')
    $(this).addClass('active')

    $('#ratingInput').val($(this).find('.ratingNumber').text())
  })

  var removeFlash = function() {
    $('.flash').fadeOut()
  }

  setTimeout(removeFlash, 5000)

  $(document).on('click', '.js--submitForm', function(e) {
    $(this).closest('form').submit()
  })

  $(document).on('click', '.js--openMenu', function(e) {
    $('.menuOverlay').removeClass('hidden')
  })

  $(document).on('click', '.js--closeMenu', function(e) {
    $('.menuOverlay').addClass('hidden')
  })

  $(document).on('click', '.estimateInput', function(e) {
    e.target.select()
  })

})

