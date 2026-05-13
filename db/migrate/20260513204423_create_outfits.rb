class CreateOutfits < ActiveRecord::Migration[8.0]
  def change
    create_table :outfits do |t|
      t.integer :user_id
      t.string :outfit_photo

      t.timestamps
    end
  end
end
