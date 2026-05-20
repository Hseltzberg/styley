desc "Fill the database tables with some sample data"
task({ sample_data: :environment }) do
  InspirationPin.destroy_all
  User.destroy_all
  Vibe.destroy_all
  Place.destroy_all
  OutfitSeason.destroy_all
  # destroy join tables first
  Outfit.destroy_all
  Feeling.destroy_all
  Season.destroy_all
  Occasion.destroy_all

  style_descriptions = [
    "Diane Keaton in the 70s meets French minimalism — neutral palettes, great tailoring, a little eccentric",
    "Coastal grandmother vibes, linen everything, vintage finds, effortless and unfussy",
    "Dark academia with a soft twist — lots of plaid, corduroy, and books as accessories",
  ]

  [
    { email: "alice@example.com", style: style_descriptions[0] },
    { email: "bob@example.com",   style: style_descriptions[1] },
    { email: "carol@example.com", style: style_descriptions[2] },
  ].each do |attrs|
    user = User.new
    user.email = attrs[:email]
    user.username = Faker::Internet.unique.username
    user.password = "appdev"
    user.style_description = attrs[:style]
    user.save
  end

  users = User.all

  outfit_photos = [
    "https://picsum.photos/300?random=1",
    "https://picsum.photos/300?random=2",
    "https://picsum.photos/300?random=3",
  ]
  note_headlines = [
    "Blue heels only",
    "Good for errands",
    "Power outfit",
    "Cute but not all-day",
    "Easy win",
    "Comfy and polished",
  ]

  note_details_list = [
    "Looks best with the blue heels and simple jewelry.",
    "Great for walking around and getting things done.",
    "My go-to when I want to feel extra confident.",
    "Very cute, but not ideal for sitting all day.",
    "Easy outfit when I do not want to think too hard.",
    "Comfortable enough for a long day but still feels styled.",
  ]

  10.times do
    outfit = Outfit.new
    outfit.outfit_photo = outfit_photos.sample
    outfit.user_id = users.sample.id
    outfit.note_headline = note_headlines.sample
    outfit.note_details = note_details_list.sample
    outfit.is_public = [true, false].sample
    outfit.card_size = ["small", "medium", "tall"].sample
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

  occasions = Occasion.all

  seasons = ["fall", "spring", "summer", "winter"]

  seasons.each do |a_season|
    season = Season.new
    season.name = a_season

    season.save
  end

  seasons = Season.all

  outfits.each do |an_outfit|
    vibe = Vibe.new
    vibe.outfit_id = an_outfit.id
    vibe.feeling_id = feelings.sample.id
    vibe.save
  end

  outfits.each do |an_outfit|
    place = Place.new
    place.outfit_id = an_outfit.id
    place.occasion_id = occasions.sample.id
    place.save
  end

  outfits.each do |an_outfit|
    outfit_season = OutfitSeason.new
    outfit_season.outfit_id = an_outfit.id
    outfit_season.season_id = seasons.sample.id
    outfit_season.save
  end

  p "Added #{Outfit.count} outfits"

  p "Added #{User.count} users"

  p "Added #{Feeling.count} feelings"

  p "Added #{Vibe.count} vibes"

  p "Added #{Occasion.count} occasions"

  p "Added #{Season.count} seasons"

  p "Added #{Place.count} places"

  p "Added #{OutfitSeason.count} outfit_seasons"

  users = User.all

  [
    {
      title: "Quiet Luxury Weekend",
      editorial_reference: "The Row F/W 2019 lookbook",
      description: "Ivory cashmere turtleneck tucked into wide-leg camel trousers, finished with simple leather loafers. Nothing loud, everything considered.",
      why_timeless: "Neutral palette and precise tailoring transcend seasons and decades.",
      color_palette: ["#e8dcc8", "#c4a882", "#f5f0e8"].to_json,
      key_pieces: ["cashmere turtleneck", "wide-leg trousers", "leather loafers"].to_json
    },
    {
      title: "Parisian Off-Duty",
      editorial_reference: "Helmut Lang S/S 1998 runway",
      description: "Slim dark denim, a crisp white poplin shirt slightly untucked, and a structured black blazer thrown over the shoulders. Effortless but precise.",
      why_timeless: "The white shirt and dark denim combination has anchored wardrobes for fifty years.",
      color_palette: ["#1a1a2e", "#ffffff", "#2d2d2d"].to_json,
      key_pieces: ["white poplin shirt", "dark slim denim", "structured blazer"].to_json
    }
  ].each do |pin_attrs|
    pin = InspirationPin.new(pin_attrs)
    pin.user_id = users.sample.id
    pin.save
  end

  p "Added #{InspirationPin.count} inspiration pins"
end
