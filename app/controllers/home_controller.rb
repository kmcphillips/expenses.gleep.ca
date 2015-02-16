class HomeController < AuthenticatedController

  def index
    @recent_entries = Entry.recent
  end

end
