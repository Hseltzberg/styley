# == Schema Information
#
# Table name: collections
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_collections_on_user_id_and_name  (user_id,name) UNIQUE
#
class Collection < ApplicationRecord
  belongs_to :user
  has_many :outfit_collections, dependent: :destroy
  has_many :outfits, through: :outfit_collections, source: :outfit

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
end
