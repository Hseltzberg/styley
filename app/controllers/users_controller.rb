class UsersController < ApplicationController
  def index
    render({ :template => "home"})
end
end
