class OccasionsController < ApplicationController
  def index
    matching_occasions = Occasion.all

    @list_of_occasions = matching_occasions.order({ :created_at => :desc })

    render({ :template => "occasion_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_occasions = Occasion.where({ :id => the_id })

    @the_occasion = matching_occasions.at(0)

    render({ :template => "occasion_templates/show" })
  end

  def create
    the_occasion = Occasion.new
    the_occasion.name = params.fetch("query_name")

    if the_occasion.valid?
      the_occasion.save
      redirect_to("/occasions", { :notice => "Occasion created successfully." })
    else
      redirect_to("/occasions", { :alert => the_occasion.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_occasion = Occasion.where({ :id => the_id }).at(0)

    the_occasion.name = params.fetch("query_name")

    if the_occasion.valid?
      the_occasion.save
      redirect_to("/occasions/#{the_occasion.id}", { :notice => "Occasion updated successfully." } )
    else
      redirect_to("/occasions/#{the_occasion.id}", { :alert => the_occasion.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_occasion = Occasion.where({ :id => the_id }).at(0)

    the_occasion.destroy

    redirect_to("/occasions", { :notice => "Occasion deleted successfully." } )
  end
end
