class OutfitsController < ApplicationController

  def index
    render({ :template => "outfit_templates/index" })
  end

  def post
    render({ :template => "outfit_templates/post" })
  end
  
  def show
    render({:template => "outfit_templates/show"})
  end
end
