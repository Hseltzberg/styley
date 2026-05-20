class CreateInspirationPins < ActiveRecord::Migration[8.0]
  def change
    create_table :inspiration_pins do |t|
      t.integer :user_id
      t.string :title
      t.string :editorial_reference
      t.text :description
      t.string :why_timeless
      t.string :color_palette
      t.string :key_pieces

      t.timestamps
    end
  end
end
