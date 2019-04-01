class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :amount
      t.references :drink, foreign_key: true
      t.boolean :liquor, default: false
      t.boolean :mixer, default: false
      t.integer :pump
      t.timestamps
    end
  end
end
