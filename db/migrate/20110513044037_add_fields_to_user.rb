class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name,  :string
    add_column :users, :address,    :string
    add_column :users, :city,       :string
    add_column :users, :country,    :string
    add_column :users, :phone,      :string
    remove_column :users, :name

    add_column :orders, :user_id,   :integer

    add_index :orders, :user_id

    add_index :users, :last_name
    add_index :users, :first_name
  end

  def self.down
    remove_index :orders, :user_id

    remove_index :users, :last_name
    remove_index :users, :first_name

    remove_column :orders, :user_id

    add_column :users, :name

    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :address
    remove_column :users, :city
    remove_column :users, :country
    remove_column :users, :phone

  end
end
