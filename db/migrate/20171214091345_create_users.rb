class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      #
      t.column :scout_name,
               :string,
               null: false

      t.index %i[ scout_name ],
              unique: true,
              name: 'scout_name_of_user'

      #
      t.column :first_name,
               :string,
               null: false

      #
      t.column :last_name,
               :string,
               null: false

      # {
      t.column :description,
               :text,
               null: true

      #
      t.column :encrypted_password,
               :string,
               null: false

      #
      t.column :is_admin,
               :boolean,
               null: false,
               default: false

      #
      t.column :avatar,
               :string,
               null: true

      #
      t.column :reset_password_token,
               :string

      t.index %i[ reset_password_token ],
              unique: true,
              name: 'reset_password_token_of_user'

      #
      t.column :reset_password_sent_at,
               :datetime

      #
      t.column :remember_created_at,
               :datetime

      #
      t.column :sign_in_count,
               :integer,
               default: 0,
               null: false

      #
      t.column :current_sign_in_at,
               :datetime

      #
      t.column :last_sign_in_at,
               :datetime

      #
      t.column :current_sign_in_ip,
               :string

      #
      t.column :last_sign_in_ip,
               :string

      #
      t.timestamps null: false
    end
  end
end
