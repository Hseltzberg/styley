class CreateCollections < ActiveRecord::Migration[8.0]
  def change
    create_table :collections do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.timestamps
    end
    add_index :collections, [:user_id, :name], unique: true

    create_table :outfit_collections do |t|
      t.integer :outfit_id, null: false
      t.integer :collection_id, null: false
      t.timestamps
    end
    add_index :outfit_collections, [:collection_id, :outfit_id], unique: true
    add_index :outfit_collections, :outfit_id
  end
end
