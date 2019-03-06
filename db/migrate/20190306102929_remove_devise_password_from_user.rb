class RemoveDevisePasswordFromUser < ActiveRecord::Migration[5.2]
  def change
    return unless column_exists? :users, :encrypted_password
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
  end
end
