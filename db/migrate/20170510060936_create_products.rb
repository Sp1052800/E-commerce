class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :brand
      t.string :name
      t.string :size
      t.string :price

      t.timestamps
    end
  end
end
