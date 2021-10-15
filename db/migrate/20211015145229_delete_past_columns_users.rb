class DeletePastColumnsUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password_digest, :string
    remove_column :users, :username, :string
  end
end
