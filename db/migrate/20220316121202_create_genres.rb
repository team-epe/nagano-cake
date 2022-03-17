class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      ##追加カラム
      #t.integer :id, null: false
      t.string :name, null: false
      #t.datetime :created_at, null: false, default: "now"
      #t.datetime :updated_at, null: false, default: "now"

      t.timestamps
    end
  end
end
