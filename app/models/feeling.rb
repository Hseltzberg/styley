# == Schema Information
#
# Table name: feelings
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Feeling < ApplicationRecord
has_many  :vibes, dependent: :destroy
has_many :outfits, through: :vibes, source: :outfit
end
