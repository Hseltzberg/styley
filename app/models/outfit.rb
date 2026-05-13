# == Schema Information
#
# Table name: outfits
#
#  id           :bigint           not null, primary key
#  outfit_photo :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
class Outfit < ApplicationRecord
end
