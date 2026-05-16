class OutfitsController < ApplicationController
  def index
    matching_outfits = Outfit.where({ :user_id => current_user.id })

    @selected_season_names = []

    if params.fetch("query_season_fall", "") != ""
      @selected_season_names.push("fall")
    end

    if params.fetch("query_season_winter", "") != ""
      @selected_season_names.push("winter")
    end

    if params.fetch("query_season_spring", "") != ""
      @selected_season_names.push("spring")
    end

    if params.fetch("query_season_summer", "") != ""
      @selected_season_names.push("summer")
    end

    if @selected_season_names.count > 0
      matching_seasons = Season.where({ :name => @selected_season_names })
      selected_season_ids = matching_seasons.map do |a_season|
        a_season.id
      end

      matching_outfit_seasons = OutfitSeason.where({ :season_id => selected_season_ids })
      selected_outfit_ids = matching_outfit_seasons.map do |an_outfit_season|
        an_outfit_season.outfit_id
      end

      matching_outfits = matching_outfits.where({ :id => selected_outfit_ids })
    end
    @list_of_feelings = Feeling.where({}).order({ :name => :asc })
    @selected_feeling_names = []

    @list_of_feelings.each do |a_feeling|
      if params.fetch("query_feeling_#{a_feeling.id}", "") != ""
        @selected_feeling_names.push(a_feeling.name)
      end
    end

    if @selected_feeling_names.count > 0
      matching_feelings = Feeling.where({ :name => @selected_feeling_names })
      selected_feeling_ids = matching_feelings.map do |a_feeling|
        a_feeling.id
      end

      matching_vibes = Vibe.where({ :feeling_id => selected_feeling_ids })
      selected_outfit_ids = matching_vibes.map do |a_vibe|
        a_vibe.outfit_id
      end

      matching_outfits = matching_outfits.where({ :id => selected_outfit_ids })
    end
    @list_of_occasions = Occasion.where({}).order({ :name => :asc })
    @selected_occasion_names = []

    @list_of_occasions.each do |an_occasion|
      if params.fetch("query_occasion_#{an_occasion.id}", "") != ""
        @selected_occasion_names.push(an_occasion.name)
      end
    end

    if @selected_occasion_names.count > 0
      matching_occasions = Occasion.where({ :name => @selected_occasion_names })
      selected_occasion_ids = matching_occasions.map do |an_occasion|
        an_occasion.id
      end

      matching_places = Place.where({ :occasion_id => selected_occasion_ids })
      selected_outfit_ids = matching_places.map do |a_place|
        a_place.outfit_id
      end

      matching_outfits = matching_outfits.where({ :id => selected_outfit_ids })
    end

    @list_of_outfits = matching_outfits.order({ :created_at => :desc })

    render({ :template => "outfit_templates/index" })
  end

  def show
    matching_outfits = Outfit.where({ :id => params.fetch("path_id") })
    @the_outfit = matching_outfits.at(0)

    render({ :template => "outfit_templates/show" })
  end

  def new_form
    @list_of_feelings = Feeling.where({}).order({ :name => :asc })
    @list_of_occasions = Occasion.where({}).order({ :name => :asc })
    @list_of_seasons = Season.where({}).order({ :name => :asc })

    render({ :template => "outfit_templates/new_form" })
  end

  def create
    the_outfit = Outfit.new
    the_outfit.user_id = current_user.id
    the_outfit.outfit_photo = params.fetch("query_outfit_photo")

    the_outfit.save

    new_feeling_name_1 = params.fetch("query_new_feeling_1", "").strip

    if new_feeling_name_1 != ""
      feeling_1 = Feeling.new
      feeling_1.name = new_feeling_name_1
      feeling_1.save

      vibe_1 = Vibe.new
      vibe_1.outfit_id = the_outfit.id
      vibe_1.feeling_id = feeling_1.id
      vibe_1.save
    end

    new_feeling_name_2 = params.fetch("query_new_feeling_2", "").strip

    if new_feeling_name_2 != ""
      feeling_2 = Feeling.new
      feeling_2.name = new_feeling_name_2
      feeling_2.save

      vibe_2 = Vibe.new
      vibe_2.outfit_id = the_outfit.id
      vibe_2.feeling_id = feeling_2.id
      vibe_2.save
    end

    new_feeling_name_3 = params.fetch("query_new_feeling_3", "").strip

    if new_feeling_name_3 != ""
      feeling_3 = Feeling.new
      feeling_3.name = new_feeling_name_3
      feeling_3.save

      vibe_3 = Vibe.new
      vibe_3.outfit_id = the_outfit.id
      vibe_3.feeling_id = feeling_3.id
      vibe_3.save
    end

    new_occasion_name = params.fetch("query_outfit_occasion", "").strip

    if new_occasion_name != ""
      occasion = Occasion.new
      occasion.name = new_occasion_name
      occasion.save

      place = Place.new
      place.outfit_id = the_outfit.id
      place.occasion_id = occasion.id
      place.save
    end

    new_season_name = params.fetch("query_outfit_season", "").strip

    if new_season_name != ""
      season = Season.new
      season.name = new_season_name
      season.save

      outfit_season = OutfitSeason.new
      outfit_season.outfit_id = the_outfit.id
      outfit_season.season_id = season.id
      outfit_season.save
    end

    redirect_to("/outfits")
  end

  def edit_form
    matching_outfits = Outfit.where({ :id => params.fetch("path_id") })
    @the_outfit = matching_outfits.at(0)

    @list_of_feelings = Feeling.where({}).order({ :name => :asc })
    @list_of_occasions = Occasion.where({}).order({ :name => :asc })
    @list_of_seasons = Season.where({}).order({ :name => :asc })

    render({ :template => "outfit_templates/edit_form" })
  end

  def update
    matching_outfits = Outfit.where({ :id => params.fetch("path_id") })
    the_outfit = matching_outfits.at(0)

    the_outfit.outfit_photo = params.fetch("query_outfit_photo")
    the_outfit.save

    matching_outfit_seasons = OutfitSeason.where({ :outfit_id => the_outfit.id })
    matching_outfit_seasons.each do |an_outfit_season|
      an_outfit_season.destroy
    end

    if params.fetch("query_season_winter", "") != ""
      matching_seasons = Season.where({ :name => "winter" })
      the_season = matching_seasons.at(0)

      outfit_season = OutfitSeason.new
      outfit_season.outfit_id = the_outfit.id
      outfit_season.season_id = the_season.id
      outfit_season.save
    end

    if params.fetch("query_season_spring", "") != ""
      matching_seasons = Season.where({ :name => "spring" })
      the_season = matching_seasons.at(0)

      outfit_season = OutfitSeason.new
      outfit_season.outfit_id = the_outfit.id
      outfit_season.season_id = the_season.id
      outfit_season.save
    end

    if params.fetch("query_season_summer", "") != ""
      matching_seasons = Season.where({ :name => "summer" })
      the_season = matching_seasons.at(0)

      outfit_season = OutfitSeason.new
      outfit_season.outfit_id = the_outfit.id
      outfit_season.season_id = the_season.id
      outfit_season.save
    end

    if params.fetch("query_season_fall", "") != ""
      matching_seasons = Season.where({ :name => "fall" })
      the_season = matching_seasons.at(0)

      outfit_season = OutfitSeason.new
      outfit_season.outfit_id = the_outfit.id
      outfit_season.season_id = the_season.id
      outfit_season.save
    end

    matching_vibes = Vibe.where({ :outfit_id => the_outfit.id })
    matching_vibes.each do |a_vibe|
      a_vibe.destroy
    end

    new_feeling_name_1 = params.fetch("query_new_feeling_1", "").strip
    selected_feeling_id_1 = params.fetch("query_feeling_id_1", "")

    if new_feeling_name_1 != ""
      matching_feelings = Feeling.where({ :name => new_feeling_name_1 })
      the_feeling = matching_feelings.at(0)

      if the_feeling == nil
        the_feeling = Feeling.new
        the_feeling.name = new_feeling_name_1
        the_feeling.save
      end

      vibe_1 = Vibe.new
      vibe_1.outfit_id = the_outfit.id
      vibe_1.feeling_id = the_feeling.id
      vibe_1.save
    elsif selected_feeling_id_1 != ""
      vibe_1 = Vibe.new
      vibe_1.outfit_id = the_outfit.id
      vibe_1.feeling_id = selected_feeling_id_1
      vibe_1.save
    end

    new_feeling_name_2 = params.fetch("query_new_feeling_2", "").strip
    selected_feeling_id_2 = params.fetch("query_feeling_id_2", "")

    if new_feeling_name_2 != ""
      matching_feelings = Feeling.where({ :name => new_feeling_name_2 })
      the_feeling = matching_feelings.at(0)

      if the_feeling == nil
        the_feeling = Feeling.new
        the_feeling.name = new_feeling_name_2
        the_feeling.save
      end

      vibe_2 = Vibe.new
      vibe_2.outfit_id = the_outfit.id
      vibe_2.feeling_id = the_feeling.id
      vibe_2.save
    elsif selected_feeling_id_2 != ""
      vibe_2 = Vibe.new
      vibe_2.outfit_id = the_outfit.id
      vibe_2.feeling_id = selected_feeling_id_2
      vibe_2.save
    end

    new_feeling_name_3 = params.fetch("query_new_feeling_3", "").strip
    selected_feeling_id_3 = params.fetch("query_feeling_id_3", "")

    if new_feeling_name_3 != ""
      matching_feelings = Feeling.where({ :name => new_feeling_name_3 })
      the_feeling = matching_feelings.at(0)

      if the_feeling == nil
        the_feeling = Feeling.new
        the_feeling.name = new_feeling_name_3
        the_feeling.save
      end

      vibe_3 = Vibe.new
      vibe_3.outfit_id = the_outfit.id
      vibe_3.feeling_id = the_feeling.id
      vibe_3.save
    elsif selected_feeling_id_3 != ""
      vibe_3 = Vibe.new
      vibe_3.outfit_id = the_outfit.id
      vibe_3.feeling_id = selected_feeling_id_3
      vibe_3.save
    end

    matching_places = Place.where({ :outfit_id => the_outfit.id })
    matching_places.each do |a_place|
      a_place.destroy
    end

    new_occasion_name_1 = params.fetch("query_new_occasion_1", "").strip
    selected_occasion_id_1 = params.fetch("query_occasion_id_1", "")

    if new_occasion_name_1 != ""
      matching_occasions = Occasion.where({ :name => new_occasion_name_1 })
      the_occasion = matching_occasions.at(0)

      if the_occasion == nil
        the_occasion = Occasion.new
        the_occasion.name = new_occasion_name_1
        the_occasion.save
      end

      place_1 = Place.new
      place_1.outfit_id = the_outfit.id
      place_1.occasion_id = the_occasion.id
      place_1.save
    elsif selected_occasion_id_1 != ""
      place_1 = Place.new
      place_1.outfit_id = the_outfit.id
      place_1.occasion_id = selected_occasion_id_1
      place_1.save
    end

    new_occasion_name_2 = params.fetch("query_new_occasion_2", "").strip
    selected_occasion_id_2 = params.fetch("query_occasion_id_2", "")

    if new_occasion_name_2 != ""
      matching_occasions = Occasion.where({ :name => new_occasion_name_2 })
      the_occasion = matching_occasions.at(0)

      if the_occasion == nil
        the_occasion = Occasion.new
        the_occasion.name = new_occasion_name_2
        the_occasion.save
      end

      place_2 = Place.new
      place_2.outfit_id = the_outfit.id
      place_2.occasion_id = the_occasion.id
      place_2.save
    elsif selected_occasion_id_2 != ""
      place_2 = Place.new
      place_2.outfit_id = the_outfit.id
      place_2.occasion_id = selected_occasion_id_2
      place_2.save
    end

    new_occasion_name_3 = params.fetch("query_new_occasion_3", "").strip
    selected_occasion_id_3 = params.fetch("query_occasion_id_3", "")

    if new_occasion_name_3 != ""
      matching_occasions = Occasion.where({ :name => new_occasion_name_3 })
      the_occasion = matching_occasions.at(0)

      if the_occasion == nil
        the_occasion = Occasion.new
        the_occasion.name = new_occasion_name_3
        the_occasion.save
      end

      place_3 = Place.new
      place_3.outfit_id = the_outfit.id
      place_3.occasion_id = the_occasion.id
      place_3.save
    elsif selected_occasion_id_3 != ""
      place_3 = Place.new
      place_3.outfit_id = the_outfit.id
      place_3.occasion_id = selected_occasion_id_3
      place_3.save
    end

    redirect_to("/outfits/#{the_outfit.id}")
  end

  def destroy
    matching_outfits = Outfit.where({ :id => params.fetch("path_id") })
    the_outfit = matching_outfits.at(0)

    the_outfit.destroy

    redirect_to("/outfits")
  end
end
