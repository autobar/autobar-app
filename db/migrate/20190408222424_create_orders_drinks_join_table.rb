class CreateOrdersDrinksJoinTable < ActiveRecord::Migration[5.2]
  def change
  
    # If you want to add an index for faster querying through this join:
    create_join_table :orders, :drinks do |t|
      t.index :order_id
      t.index :drink_id
    end
  end
end
