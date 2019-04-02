require "colorable"
include Colorable

class ColoursController < ApplicationController

  def show
    @colour = Colour.find_by_id(params[:id])
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
  	render nothing: true and return unless color_exist? 
  	@color = Color.new(params[:color])
    Palette.colors.push({r: @color.rgb[0], g: @color.rgb[1], b: @color.rgb[2], name: params[:name]})
  end

  def destroy
  	colour = Colour.find_by_id(params[:id])
  	colour.destroy
  	redirect_back(fallback_location: root_url)
  end

  private

  def colour_params
  	params.require(:colour).permit(:R, :G, :B, :name)
  end

  def color_exist?
   	params[:color] =~ /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
  end
end
