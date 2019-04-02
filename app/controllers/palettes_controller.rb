require "colorable"
include Colorable

class PalettesController < ApplicationController
  
  def show
    @palette = Palette.find_by_id(params[:id])
  end

  def new
  end

  def create
    palette = Palette.new(palette_params)
    if palette.save
      Palette.colors.each do |color|
        c = Colour.create(R: color[:r], G: color[:g], B: color[:b], name: color[:name])
        palette.colours << c
      end
      redirect_to root_url
    else
      redirect_back(fallback_location: root_url)
    end
  end

  def index
    @palettes = Palette.all
  end

  def destroy
    palette = Palette.find(params[:id])
    palette.destroy
    redirect_back(fallback_location: root_url)
  end

  def update
    palette = Palette.find(params[:id])
    palette.name = params[:palette][:name]
    palette.save
    redirect_back(fallback_location: root_url)
  end

  def add_colour
    c = Color.new(params[:color])
    colour = Colour.create(R: c.rgb[0], G: c.rgb[1], B: c.rgb[2], name: params[:name])
    palette = Palette.find(params[:id])
    palette.colours << colour
    redirect_back(fallback_location: root_url)
  end

  private

  def palette_params
    params.require(:palette).permit(:name)
  end
end
