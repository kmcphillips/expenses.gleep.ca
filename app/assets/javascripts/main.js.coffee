$ ->
  $('#entry_type_filter_select').on 'change', ->
    window.location = "/entries?category_id=#{ $(this).val() }"

  $('#incurred_until_group_toggle').on 'change', Expenses.toggleIncurredUntil
  Expenses.toggleIncurredUntil()


class Expenses
  @toggleIncurredUntil: ->
    if $('#incurred_until_group_toggle').prop('checked')
      $('#incurred_until_group').show()
    else
      $('#incurred_until_group').hide()
      $('#incurred_until_group input').val('')
