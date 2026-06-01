# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

["fall", "spring", "summer", "winter"].each do |name|
  Season.find_or_create_by!(name: name)
end

["confident", "elegant", "comfortable", "capable", "calm", "energetic", "creative"].each do |name|
  Feeling.find_or_create_by!(name: name)
end

["work", "dinner party", "brunch", "big presentation", "date night", "vacation", "sight seeing"].each do |name|
  Occasion.find_or_create_by!(name: name)
end
