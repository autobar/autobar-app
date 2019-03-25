class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.boolean :completed

      t.belongs_to :order, index: true
      
      t.timestamps
    end
  end
end
