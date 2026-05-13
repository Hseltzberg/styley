Rails.application.routes.draw do
  devise_for :users
  get("/", :controller => "pages", :action => "home")

  get("/outfits", :controller => "outfits", :action => "index")
  get("/insert_outfit_form", :controller => "outfits", :action => "post")
  # get("/outfits/:outfit_id"), :controller => "outfits", "action" => "show"
end
