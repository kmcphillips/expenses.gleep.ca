module ApplicationHelper

  def page_title
    content_for?(:title) ? yield(:title) : "Expenses"
  end

  def boolean_glyph(value)
    if value
      content_tag :i, "", class: "icon-ok text-success"
    else
      content_tag :i, "", class: "icon-remove text-warning"
    end
  end

  def data_area?
    params[:controller] == "data"
  end

  def formatted_currency(number)
    content_tag(:span, number_to_currency(number.to_f, precision: 2), class: (number < 0 ? "text-error" : ""))
  end

end
