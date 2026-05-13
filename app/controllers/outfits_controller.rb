class OutfitsController < ApplicationController

  def index
    matching_outfits = Outfit.where({ :user_id => current_user.id })
    @list_of_outfits = matching_outfits.order({ :created_at => :desc })

    render({ :template => "outfit_templates/index" })
  end

  def new_form
    render({ :template => "outfit_templates/new_form" })
  end

  def create
    the_outfit = Outfit.new
    the_outfit.user_id = current_user.id
    the_outfit.outfit_photo = params.fetch("query_outfit_photo")

    the_outfit.save

    redirect_to("/outfits")
  end

  def show
    render({ :template => "outfit_templates/show" })
  end
  
end
