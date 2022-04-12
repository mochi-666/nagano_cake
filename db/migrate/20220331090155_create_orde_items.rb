class CreateOrdeItems < ActiveRecord::Migration[5.2]
  def change
    create_table :orde_items do |t|
      t.integer :item_id
      t.integer :orde_id
      t.integer :price
      t.integer :amount
      t.string :production_status

      t.timestamps
    end
  end
end
