class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  
  def home
  end

  def favorites
    @flats = Flat.select("flats.*, search_param_flats.id as search_param_flat_id, search_param_flats.*")
      .joins(:search_param_flats)
      .where(search_param_flats: { search_param_id: current_user.search_param.select(:id), liked: true })
      .order(emailed_at: :desc)
  end

end