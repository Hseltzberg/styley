class VibesController < ApplicationController
  def index
    matching_vibes = Vibe.all

    @list_of_vibes = matching_vibes.order({ :created_at => :desc })

    render({ :template => "vibe_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_vibes = Vibe.where({ :id => the_id })

    @the_vibe = matching_vibes.at(0)

    render({ :template => "vibe_templates/show" })
  end

  def create
    the_vibe = Vibe.new
    the_vibe.outfit_id = params.fetch("query_outfit_id")
    the_vibe.feeling_id = params.fetch("query_feeling_id")

    if the_vibe.valid?
      the_vibe.save
      redirect_to("/vibes", { :notice => "Vibe created successfully." })
    else
      redirect_to("/vibes", { :alert => the_vibe.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_vibe = Vibe.where({ :id => the_id }).at(0)

    the_vibe.outfit_id = params.fetch("query_outfit_id")
    the_vibe.feeling_id = params.fetch("query_feeling_id")

    if the_vibe.valid?
      the_vibe.save
      redirect_to("/vibes/#{the_vibe.id}", { :notice => "Vibe updated successfully." } )
    else
      redirect_to("/vibes/#{the_vibe.id}", { :alert => the_vibe.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_vibe = Vibe.where({ :id => the_id }).at(0)

    the_vibe.destroy

    redirect_to("/vibes", { :notice => "Vibe deleted successfully." } )
  end
end
