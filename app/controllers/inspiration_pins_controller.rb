class InspirationPinsController < ApplicationController
  def index
    @pins = current_user.inspiration_pins.order(created_at: :desc)
  end

  def create
    pin = current_user.inspiration_pins.new(
      title:               params[:title],
      editorial_reference: params[:editorial_reference],
      description:         params[:description],
      why_timeless:        params[:why_timeless],
      color_palette:       params[:color_palette],
      key_pieces:          params[:key_pieces]
    )
    pin.save
    if turbo_frame_request?
      render :create
    else
      redirect_to("/mood-board")
    end
  end

  def destroy
    pin = current_user.inspiration_pins.find_by(id: params[:path_id])
    pin&.destroy
    redirect_to("/mood-board")
  end
end
