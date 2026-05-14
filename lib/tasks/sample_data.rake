desc "Fill the database tables with some sample data"
task({ sample_data: :environment }) do

  User.destroy_all
  Vibe.destroy_all
  # destroy join tables first
  Outfit.destroy_all
  Feeling.destroy_all
  Season.destroy_all
  Occasion.destroy_all

emails = ["alice@example.com", "bob@example.com", "carol@example.com"]

  emails.each do |an_email|
    user = User.new
    user.email = an_email
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

  feelings = ["confident", "elegant", "comfortable", "capable", "calm", "energetic"]

  feelings.each do |a_feeling|
    feeling = Feeling.new
    feeling.name = a_feeling

    feeling.save
  end

  feelings = Feeling.all

  occasions = ["work", "dinner party", "brunch", "big presentation", "date night", "vacation"]

  occasions.each do |an_occasion|
    occasion = Occasion.new
    occasion.name = an_occasion

    occasion.save
  end

  seasons = ["fall", "spring", "summer", "winter"]

  seasons.each do |a_season|
    season = Season.new
    season.name = a_season

    season.save
  end

  6.times do
    
    vibe = Vibe.new

    vibe.feeling_id = feelings.sample.id
    vibe.outfit_id = outfits.sample.id

    vibe.save

  end


  p "Added #{Outfit.count} outfits"

  p "Added #{User.count} users"

  p "Added #{Feeling.count} feelings"

  p "Added #{Vibe.count} vibes"

  p "Added #{Occasion.count} occasions"

  p "Added #{Season.count} seasons"

end
