class CreateOutfitSeasons < ActiveRecord::Migration[8.0]
  def change
    create_table :outfit_seasons do |t|
      t.integer :outfit_id
      t.integer :season_id

      t.timestamps
    end
  end
end
