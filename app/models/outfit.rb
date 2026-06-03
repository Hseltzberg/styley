# == Schema Information
#
# Table name: outfits
#
#  id              :bigint           not null, primary key
#  card_size       :string           default("medium"), not null
#  is_public       :boolean          default(FALSE), not null
#  note_details    :text
#  note_headline   :string
#  note_reflection :text
#  outfit_photo    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#
class Outfit < ApplicationRecord
mount_uploader(:outfit_photo, OutfitPhotoUploader)
  belongs_to(:user, counter_cache: :outfit_uploads_count)
  has_many(:places, dependent: :destroy)
  has_many(:vibes, dependent: :destroy)
  has_many(:outfit_seasons, dependent: :destroy)
  has_many :feelings, through: :vibes, source: :feeling
  has_many :seasons, through: :outfit_seasons, source: :season
  has_many :occasions, through: :places, source: :occasion
end
