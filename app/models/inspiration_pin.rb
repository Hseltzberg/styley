# == Schema Information
#
# Table name: inspiration_pins
#
#  id                 :bigint           not null, primary key
#  user_id            :integer
#  title              :string
#  editorial_reference :string
#  description        :text
#  why_timeless       :string
#  color_palette      :string
#  key_pieces         :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class InspirationPin < ApplicationRecord
  belongs_to :user

  def color_palette_array
    JSON.parse(color_palette || "[]")
  rescue JSON::ParserError
    []
  end

  def key_pieces_array
    JSON.parse(key_pieces || "[]")
  rescue JSON::ParserError
    []
  end
end
