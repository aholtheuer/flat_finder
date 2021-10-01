class AddUserIdToSearchParams < ActiveRecord::Migration[6.1]
  def change
    add_column :search_params, :user_id, :int
  end
end
