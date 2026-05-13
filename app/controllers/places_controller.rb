class PlacesController < ApplicationController
  def index
    matching_places = Place.all

    @list_of_places = matching_places.order({ :created_at => :desc })

    render({ :template => "place_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_places = Place.where({ :id => the_id })

    @the_place = matching_places.at(0)

    render({ :template => "place_templates/show" })
  end

  def create
    the_place = Place.new
    the_place.outfit_id = params.fetch("query_outfit_id")
    the_place.occasion_id = params.fetch("query_occasion_id")

    if the_place.valid?
      the_place.save
      redirect_to("/places", { :notice => "Place created successfully." })
    else
      redirect_to("/places", { :alert => the_place.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_place = Place.where({ :id => the_id }).at(0)

    the_place.outfit_id = params.fetch("query_outfit_id")
    the_place.occasion_id = params.fetch("query_occasion_id")

    if the_place.valid?
      the_place.save
      redirect_to("/places/#{the_place.id}", { :notice => "Place updated successfully." } )
    else
      redirect_to("/places/#{the_place.id}", { :alert => the_place.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_place = Place.where({ :id => the_id }).at(0)

    the_place.destroy

    redirect_to("/places", { :notice => "Place deleted successfully." } )
  end
end
