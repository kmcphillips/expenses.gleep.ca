$ ->
  $('#entry_type_filter_select').on 'change', ->
    window.location = "/entries?category_id=#{ $(this).val() }"
