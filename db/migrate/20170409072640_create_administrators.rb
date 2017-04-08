class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :email
      t.string :email_for_index
      t.string :hashed_password
      t.boolean :suspended
      t.timestamps
    end

    add_index :administrators, :email_for_index, unique: true
  end
end
