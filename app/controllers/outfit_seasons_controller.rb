class OutfitSeasonsController < ApplicationController
  def index
    matching_outfit_seasons = OutfitSeason.all

    @list_of_outfit_seasons = matching_outfit_seasons.order({ :created_at => :desc })

    render({ :template => "outfit_season_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_outfit_seasons = OutfitSeason.where({ :id => the_id })

    @the_outfit_season = matching_outfit_seasons.at(0)

    render({ :template => "outfit_season_templates/show" })
  end

  def create
    the_outfit_season = OutfitSeason.new
    the_outfit_season.outfit_id = params.fetch("query_outfit_id")
    the_outfit_season.season_id = params.fetch("query_season_id")

    if the_outfit_season.valid?
      the_outfit_season.save
      redirect_to("/outfit_seasons", { :notice => "Outfit season created successfully." })
    else
      redirect_to("/outfit_seasons", { :alert => the_outfit_season.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_outfit_season = OutfitSeason.where({ :id => the_id }).at(0)

    the_outfit_season.outfit_id = params.fetch("query_outfit_id")
    the_outfit_season.season_id = params.fetch("query_season_id")

    if the_outfit_season.valid?
      the_outfit_season.save
      redirect_to("/outfit_seasons/#{the_outfit_season.id}", { :notice => "Outfit season updated successfully." } )
    else
      redirect_to("/outfit_seasons/#{the_outfit_season.id}", { :alert => the_outfit_season.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_outfit_season = OutfitSeason.where({ :id => the_id }).at(0)

    the_outfit_season.destroy

    redirect_to("/outfit_seasons", { :notice => "Outfit season deleted successfully." } )
  end
end
