class ColoursController < ApplicationController
  def show
    @colour = Colour.find_by_id(params[:id])
  end

  def new
  end

  def update
    colour = Colour.find.find_by_id(params[:id])
    colour.update(colour_params)
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
  	colour = Colour.find_by_id(params[:id])
  	flash[:error] = "colour not deleted" unless colour.destroy
  	redirect_back(fallback_location: root_url)
  end

  private

  def colour_params
  	params.require(:colour).permit(:name, :hex)
  end

  def color_exist?
   	params[:color] =~ /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
  end
end
