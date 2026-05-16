class AddIsPublicToOutfits < ActiveRecord::Migration[8.0]
  def change
    add_column(:outfits, :is_public, :boolean, default: false, null: false)
  end
end
