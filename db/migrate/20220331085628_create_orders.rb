class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :postage
      t.integer :total_payment
      t.integer :payment_method
      t.integer :salesorder

      t.timestamps
    end
  end
end
