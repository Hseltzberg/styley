class AddCardSizeToOutfits < ActiveRecord::Migration[8.0]
  def change
    add_column(:outfits, :card_size, :string, default: "medium", null: false)
  end
end
