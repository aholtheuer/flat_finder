class AddLikedToSearchParamsFlats < ActiveRecord::Migration[6.1]
  def change
    add_column :search_param_flats, :liked, :boolean, default: false
  end
end
