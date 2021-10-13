class AddEmailedAtToSearchParamFlats < ActiveRecord::Migration[6.1]
  def change
    add_column :search_param_flats, :emailed_at, :datetime, null: true
  end
end
