class PalettesController < ApplicationController
  before_action :find_palette, only: [:show, :edit, :destroy, :update]

  def show
  end

  def edit
    @colours = @palette.colours
  end

  def new
    @colours = Colour.all
    @palette = Palette.new
  end

  def create
    @palette = Palette.new(palette_params)
    if @palette.save
      params[:palette][:colour_ids].each do |color|
        colour = Colour.find_by_id(color)
        @palette.colours << colour if colour
      end
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @palettes = Palette.order('name').page(params[:page]).per(6)
  end

  def destroy
    @palette.destroy
    redirect_back(fallback_location: root_url)
  end

  def update
    if @palette.update(palette_params)
      params[:palette][:colour_ids].each do |color|
        colour = Colour.find_by_id(color)
        @palette.colours << colour if colour
      end
      flash[:success] = 'Palette Updated successfully'
      redirect_to @palette
    else
      render 'edit'
    end
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
