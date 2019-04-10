class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number, default: "+10000000000"
      t.string :drivers_license
      t.boolean :is_admin, default: false
      
      t.timestamps
    end
  end
end
