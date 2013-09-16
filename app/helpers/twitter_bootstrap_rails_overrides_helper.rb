module TwitterBootstrapRailsOverridesHelper

  # Hack until my PR in twitter-bootstrap-rails gets merged to support an :active flag
  def menu_item_entries_override(name=nil, path="#", *args, &block)
    result = menu_item(name, path, args, block)
    result = result.gsub(" class=\"active\"", "") if params[:controller] == "entries" && params[:action] == "new"
    result.html_safe
  end

end
