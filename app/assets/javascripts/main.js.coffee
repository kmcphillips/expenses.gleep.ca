$ ->
  $('#entry_type_filter_select').on 'change', ->
    window.location = "/entries?category_id=#{ $(this).val() }"

  $('#incurred_until_group_toggle').on 'change', Expenses.toggleIncurredUntil
  Expenses.toggleIncurredUntil()

  $(document).on 'click', "[data-form-actions-spinner]", ->
    $(this).closest('.form-actions').find("input[type=submit], button, a.btn").addClass("disabled")


class Expenses
  @toggleIncurredUntil: ->
    if $('#incurred_until_group_toggle').prop('checked')
      $('#incurred_until_group').removeClass("hidden")
    else
      $('#incurred_until_group').addClass("hidden")
      $('#incurred_until_group input').val('')
