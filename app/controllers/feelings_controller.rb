class FeelingsController < ApplicationController
  def index
    matching_feelings = Feeling.all

    @list_of_feelings = matching_feelings.order({ :created_at => :desc })

    render({ :template => "feeling_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_feelings = Feeling.where({ :id => the_id })

    @the_feeling = matching_feelings.at(0)

    render({ :template => "feeling_templates/show" })
  end

  def create
    the_feeling = Feeling.new
    the_feeling.name = params.fetch("query_name")

    if the_feeling.valid?
      the_feeling.save
      redirect_to("/feelings", { :notice => "Feeling created successfully." })
    else
      redirect_to("/feelings", { :alert => the_feeling.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_feeling = Feeling.where({ :id => the_id }).at(0)

    the_feeling.name = params.fetch("query_name")

    if the_feeling.valid?
      the_feeling.save
      redirect_to("/feelings/#{the_feeling.id}", { :notice => "Feeling updated successfully." } )
    else
      redirect_to("/feelings/#{the_feeling.id}", { :alert => the_feeling.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_feeling = Feeling.where({ :id => the_id }).at(0)

    the_feeling.destroy

    redirect_to("/feelings", { :notice => "Feeling deleted successfully." } )
  end
end
