class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      ##追加カラム
      #t.integer :id, null: false
      t.integer :customer_id, null: false
      t.string :postal_code, null: false
      t.string :addresses, null: false
      t.string :name, null: false
      #t.datetime :created_at, null: false, default: "now"
      #t.datetime :updated_at, null: false, default: "now"

      t.timestamps
    end
  end
end
