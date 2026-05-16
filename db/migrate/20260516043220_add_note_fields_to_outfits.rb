class AddNoteFieldsToOutfits < ActiveRecord::Migration[8.0]
  def change
    add_column :outfits, :note_headline, :string
    add_column :outfits, :note_details, :text
  end
end
