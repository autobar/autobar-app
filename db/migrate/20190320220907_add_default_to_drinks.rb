class AddDefaultToDrinks < ActiveRecord::Migration[5.0]
  def change
    change_column :drinks, :default, :boolean, default: false
  end
end
