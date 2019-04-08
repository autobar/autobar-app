class FixOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :order_id
    
    # add the column to the drinks
    #add_reference :drinks, :order, index: true
  end
end
