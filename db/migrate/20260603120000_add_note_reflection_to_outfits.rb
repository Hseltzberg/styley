class AddNoteReflectionToOutfits < ActiveRecord::Migration[8.0]
  def change
    add_column :outfits, :note_reflection, :text
  end
end
