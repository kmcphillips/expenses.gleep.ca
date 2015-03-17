module ApplicationHelper

  def page_title
    content_for?(:title) ? yield(:title) : "Expenses"
  end

  def boolean_glyph(value)
    if value
      content_tag :i, "", class: "fa fa-check text-success"
    else
      content_tag :i, "", class: "fa fa-times text-warning"
    end
  end

  def data_area?
    params[:controller] == "data"
  end

  def formatted_currency(number, opts={})
    opts = {zeroes: true}.merge(opts)

    if opts[:zeroes] || !(number.to_f == 0.0)
      content_tag(:span, number_to_currency(number.to_f, precision: 2), class: (number < 0 ? "text-danger" : ""))
    else
      nil
    end
  end

  def chart_from_json(hash, id=nil)
    hash = hash.to_h unless hash.is_a?(Hash)

    id = "chart-#{ (0...12).map{ ('a'..'z').to_a[rand(26)] }.join }" unless id
    js = "$(function(){ $('##{ id }').highcharts(#{ hash.is_a?(Hash) ? hash.to_json : hash }); });".html_safe

    [
      content_tag(:div, '', id: id),
      content_tag(:script, js, type: "text/javascript")
    ].join('').html_safe
  end

  def nav_bar_brand
    brand = "Expenses"
    brand << " <span class='label label-danger'>Development</span>" if Rails.env.development?
    brand.html_safe
  end

end
