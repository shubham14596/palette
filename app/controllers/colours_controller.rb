class ColoursController < ApplicationController
  before_action :find_colour, only: [:show, :update, :destroy]

  def show
  end

  def new
  end

  def update
    @colour.update(colour_params)
    redirect_to colours_path
  end

  def index
    @colours = Colour.all
  end

  def create
  	@colour = Colour.new(colour_params)
    flash[:error] = "Invalid Colour" unless @colour.save
  end

  def destroy
  	flash[:error] = "colour not deleted" unless @colour.destroy
  	redirect_back(fallback_location: root_url)
  end

  private

  def find_colour
    render 'no_colour' unless @colour = Colour.find_by_id(params[:id])
  end

  def colour_params
  	params.require(:colour).permit(:name, :hex)
  end
end
