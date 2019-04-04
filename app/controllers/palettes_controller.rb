class PalettesController < ApplicationController
  before_action :find_palette, only: [:show, :destroy, :update]

  def show
  end

  def new
    @colours = Colour.all
    @palette = Palette.new
  end

  def create
    @palette = Palette.new(palette_params)
    if @palette.save
      params[:palette][:colour_ids].each do |c|
        colour = Colour.find_by_id(c)
        @palette.colours << colour if colour
      end
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @palettes = Palette.all
  end

  def destroy
    @palette.destroy
    redirect_back(fallback_location: root_url)
  end

  def update
    @palette.name = params[:palette][:name]
    @palette.save
    redirect_back(fallback_location: root_url)
  end

  private

  def find_palette
    @palette = Palette.find_by_id(params[:id])
    render 'no_palette' unless @palette 
  end

  def palette_params
    params.require(:palette).permit(:name, :color_ids)
  end
end
