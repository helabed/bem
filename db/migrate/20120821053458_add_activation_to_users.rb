class AddActivationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :active, :boolean, { :default => false }
    add_column :users, :activation_token, :string
    add_column :users, :activation_sent_at, :datetime
  end

  def self.down
    remove_column :users, :activation_sent_at
    remove_column :users, :activation_token
    remove_column :users, :active
  end
end
