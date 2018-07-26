class AddOmniauthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gh_uid, :string
    add_column :users, :gh_token, :string
  end
end
