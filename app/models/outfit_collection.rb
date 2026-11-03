# == Schema Information
#
# Table name: outfit_collections
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  collection_id :integer          not null
#  outfit_id     :integer          not null
#
# Indexes
#
#  index_outfit_collections_on_collection_id_and_outfit_id  (collection_id,outfit_id) UNIQUE
#  index_outfit_collections_on_outfit_id                    (outfit_id)
#
class OutfitCollection < ApplicationRecord
  belongs_to :outfit
  belongs_to :collection
end
