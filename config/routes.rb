Rails.application.routes.draw do
  # Routes for the Outfit resource:

  # CREATE
  post("/insert_outfit", { :controller => "outfits", :action => "create" })

  # READ
  get("/outfits", { :controller => "outfits", :action => "index" })

  get("/outfits/:path_id", { :controller => "outfits", :action => "show" })

  # UPDATE

  post("/modify_outfit/:path_id", { :controller => "outfits", :action => "update" })

  # DELETE
  get("/delete_outfit/:path_id", { :controller => "outfits", :action => "destroy" })

  #------------------------------

  devise_for :users
  get("/", :controller => "pages", :action => "home")

  # get("/outfits", :controller => "outfits", :action => "index")
  # get("/outfits/new", :controller => "outfits", :action => "new_form")
  # post("/insert_outfit", :controller => "outfits", :action => "create")
  # # get("/outfits/:outfit_id"), :controller => "outfits", "action" => "show"
end
