$(document).on('click', '.js--toggleWeekPlan', function() {
  $('.addWeeklyTodos').toggleClass('hidden')
  $('.showWeekPlan').toggleClass('hidden')
})

$(document).on('click', '.js--addWeeklyTodo', function() {
  var content = $(this).prev('span').text()

  var emptyTodo = $('.contentInput').filter(function(index, input) {
    if (input.value == '') {
      return input
    }
  })

  if (emptyTodo.length > 0) {
    $(this).text('Added')
    $(this).attr('disabled', true)
    $(emptyTodo[0]).val(content)
  }
})
