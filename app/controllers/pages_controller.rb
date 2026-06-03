class PagesController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:home] })

  def home
    if current_user.present?
      @list_of_public_outfits = Outfit.where({ :is_public => true })
      last_outfit = current_user.outfit_uploads.order(created_at: :desc).first
      @days_since_last_outfit = last_outfit ? ((Time.current - last_outfit.created_at) / 1.day).floor : nil
    else
      @list_of_public_outfits = []
    end

    render({ :template => "page_templates/home" })
  end

  def about
    render({ :template => "page_templates/about" })
  end
end
