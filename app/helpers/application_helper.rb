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

end
