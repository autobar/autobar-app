class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, default: "User X"
      t.string :phone_number, default: "+10000000000"
      t.string :drivers_license, default: ""
      t.boolean :is_admin, default: false
      
      t.timestamps
    end
  end
end
