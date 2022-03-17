class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      ##追加カラム
      #t.integer :id, null: false
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.string :image_id, null: false
      t.text :introduction, null: false
      t.boolean :is_active, null: false, default: true
      t.integer :price, null: false
      #t.datetime :created_at, null: false, default: "now"
      #t.datetime :updated_at, null: false, default: "now"


      t.timestamps
    end
  end
end
