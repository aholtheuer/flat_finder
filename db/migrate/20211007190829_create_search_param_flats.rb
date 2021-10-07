class CreateSearchParamFlats < ActiveRecord::Migration[6.1]
  def change
    create_table :search_param_flats do |t|
      t.integer :search_param_id
      t.integer :flat_id
      t.timestamps
    end
  end
end
