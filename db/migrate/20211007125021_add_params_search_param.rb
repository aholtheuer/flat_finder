class AddParamsSearchParam < ActiveRecord::Migration[6.1]
  def change
    add_column :search_params, :bedroom, :int
    add_column :search_params, :bath, :int
    add_column :search_params, :price_min, :int
    add_column :search_params, :price_max, :int 
  end
end
