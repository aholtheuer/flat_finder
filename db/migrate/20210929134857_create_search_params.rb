class CreateSearchParams < ActiveRecord::Migration[6.1]
  def change
    create_table :search_params do |t|
      t.string :title
      t.string :comuna
      t.timestamps
    end
  end
end
