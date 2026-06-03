# == Schema Information
#
# Table name: inspiration_pins
#
#  id                  :bigint           not null, primary key
#  color_palette       :string
#  description         :text
#  editorial_reference :string
#  key_pieces          :string
#  title               :string
#  why_timeless        :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
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
