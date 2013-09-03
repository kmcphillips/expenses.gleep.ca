module ApplicationHelper

  def page_title
    content_for?(:title) ? yield(:title) : "Expenses"
  end

end
