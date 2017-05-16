class CreateUserRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_roles do |t|
      t.string :role_id
      t.string :user_id

      t.timestamps
    end
  end
end
