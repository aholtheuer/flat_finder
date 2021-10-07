class CreateFlats < ActiveRecord::Migration[6.1]
  def change
    create_table :flats do |t|
      t.string :href
      t.string :name
      t.string :price
      t.string :specs
      t.string :location
      t.timestamps
    end
  end
end
