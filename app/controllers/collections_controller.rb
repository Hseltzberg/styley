class CollectionsController < ApplicationController
  def update
    the_collection = current_user.collections.where({ :id => params.fetch("path_id") }).first
    if the_collection.nil?
      redirect_to("/outfits", alert: "Collection not found.")
      return
    end

    the_collection.name = params.fetch("query_name", "").strip
    if the_collection.save
      redirect_to("/outfits#collection-#{the_collection.id}", notice: "Collection renamed.")
    else
      redirect_to("/outfits", alert: the_collection.errors.full_messages.to_sentence)
    end
  end

  def destroy
    the_collection = current_user.collections.where({ :id => params.fetch("path_id") }).first
    the_collection&.destroy

    redirect_to("/outfits", notice: "Collection deleted. Your outfits are still in your closet.")
  end
end
