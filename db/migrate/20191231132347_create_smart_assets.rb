class CreateSmartAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :smart_assets do |t|
      t.string :url, index: true
      t.integer :width
      t.integer :height
      t.integer :original_size
      t.integer :new_size
      t.string :image
      t.datetime :created_at
    end

    create_table :webp_assets do |t|
      t.string :url, index: true
      t.integer :width
      t.integer :height
      t.datetime :created_at
    end
  end
end
