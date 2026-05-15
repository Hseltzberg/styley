class OutfitsController < ApplicationController
   def index
    matching_outfits = Outfit.where({ :user_id => current_user.id })
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

    redirect_to("/outfits/#{the_outfit.id}")
  end

  def destroy
    matching_outfits = Outfit.where({ :id => params.fetch("path_id") })
    the_outfit = matching_outfits.at(0)

    the_outfit.destroy

    redirect_to("/outfits")
  end
end
