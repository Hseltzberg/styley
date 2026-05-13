class CreateVibes < ActiveRecord::Migration[8.0]
  def change
    create_table :vibes do |t|
      t.integer :outfit_id
      t.integer :feeling_id

      t.timestamps
    end
  end
end
