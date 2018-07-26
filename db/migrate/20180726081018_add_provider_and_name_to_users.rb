class AddProviderAndNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gh_provider, :string
    add_column :users, :gh_name, :string
  end
end
