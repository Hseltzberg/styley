desc "Fill the database tables with some sample data"
task({ sample_data: :environment }) do
  require "faker"
  5.times do
    user = User.new
    user.email = Faker::Internet.unique.email
    user.username = Faker::Internet.unique.username
    user.password = "appdev"
    user.save
  end

  users = User.all

  outfit_photos = [
    "https://picsum.photos/300?random=1",
    "https://picsum.photos/300?random=2",
    "https://picsum.photos/300?random=3",
  ]

  10.times do
    outfit = Outfit.new
    outfit.outfit_photo = outfit_photos.sample
    outfit.user_id = users.sample.id
    outfit.save
  end

  outfits = Outfit.all
  
  p "Added #{Outfit.count} outfits"

  p "Added #{User.count} users"
end
