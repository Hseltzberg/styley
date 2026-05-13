Rails.application.routes.draw do
  devise_for :users
  get("/", :controller => "users", :action => "index")
end
