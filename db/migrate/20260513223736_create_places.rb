class CreatePlaces < ActiveRecord::Migration[8.0]
  def change
    create_table :places do |t|
      t.integer :outfit_id
      t.integer :occasion_id

      t.timestamps
    end
  end
end
