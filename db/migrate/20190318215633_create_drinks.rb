class CreateDrinks < ActiveRecord::Migration[5.0]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :ingredients
      t.boolean :default
      t.string :tag

      t.timestamps
    end
  end
end
