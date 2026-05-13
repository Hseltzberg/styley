Rails.application.routes.draw do
  # Routes for the Occasion resource:

  # CREATE
  post("/insert_occasion", { :controller => "occasions", :action => "create" })

  # READ
  get("/occasions", { :controller => "occasions", :action => "index" })

  get("/occasions/:path_id", { :controller => "occasions", :action => "show" })

  # UPDATE

  post("/modify_occasion/:path_id", { :controller => "occasions", :action => "update" })

  # DELETE
  get("/delete_occasion/:path_id", { :controller => "occasions", :action => "destroy" })

  #------------------------------

  # Routes for the Season resource:

  # CREATE
  post("/insert_season", { :controller => "seasons", :action => "create" })

  # READ
  get("/seasons", { :controller => "seasons", :action => "index" })

  get("/seasons/:path_id", { :controller => "seasons", :action => "show" })

  # UPDATE

  post("/modify_season/:path_id", { :controller => "seasons", :action => "update" })

  # DELETE
  get("/delete_season/:path_id", { :controller => "seasons", :action => "destroy" })

  #------------------------------

  # Routes for the Feeling resource:

  # CREATE
  post("/insert_feeling", { :controller => "feelings", :action => "create" })

  # READ
  get("/feelings", { :controller => "feelings", :action => "index" })

  get("/feelings/:path_id", { :controller => "feelings", :action => "show" })

  # UPDATE

  post("/modify_feeling/:path_id", { :controller => "feelings", :action => "update" })

  # DELETE
  get("/delete_feeling/:path_id", { :controller => "feelings", :action => "destroy" })

  #------------------------------

  # Routes for the Outfit resource:

  # CREATE
  post("/insert_outfit", { :controller => "outfits", :action => "create" })

  get("/outfits/new", { :controller => "outfits", :action => "new_form" })

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

end
