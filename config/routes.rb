Rails.application.routes.draw do
  devise_for :users
  get("/", :controller => "pages", :action => "home")
end
