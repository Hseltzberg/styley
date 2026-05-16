class PagesController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:home] })

  def home
    if current_user.present?
    @list_of_public_outfits = Outfit.where({ :is_public => true })
    # .where.not({ :user_id => current_user.id })

    else
      @list_of_public_outfits = []
    end

    render({ :template => "page_templates/home" })
  end

  def about
    render({ :template => "page_templates/about" })
  end
end
