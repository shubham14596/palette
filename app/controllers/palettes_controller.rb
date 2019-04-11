class PalettesController < ApplicationController
  before_action :find_palette, only: %i[show edit destroy update]
  before_action :find_color, only: %i[new edit create update]
  before_action :find_palette_color, only: %i[create update]

  def index
    @palettes = Palette.order('id DESC').page(params[:page]).per(6)
  end

  def show; end

  def new
    @palette = Palette.new
  end

  def create
    @palette = Palette.new(palette_params)
    
    if @palette.save
      @palette_colors.each do |color|
        @palette.colours << color
      end
      flash[:success] = 'Palette created successfully'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @palette.update(palette_params)
      
      # remove colours
      colors_to_remove = @palette.colours - @palette_colors
      colors_to_remove.each { |color| @palette.colours.delete color }

      # add new colours
      @palette_colors.each do |colour|
        @palette.colours << colour if !@palette.colours.include? colour
      end

      flash[:success] = 'Palette Updated successfully'
      redirect_to @palette
    else
      render 'edit'
    end
  end

  def destroy
    flash[:success] = 'Palette deleted successfully' if @palette.destroy
    redirect_back(fallback_location: root_url)
  end

  private

  def find_palette
    @palette = Palette.find_by_id(params[:id])
    return if @palette.present?

    flash[:danger] = 'No palette found'
    redirect_to palettes_path
  end

  def find_palette_color
    @palette_colors = Colour.where(id: params[:colour_ids])
    unless @palette_colors.present?
      flash[:error] = 'Please select valid colors'
      render params[action] == 'create' ? 'new' : 'edit' && return
    end
  end

  def find_color
    @colours = Colour.all
  end

  def palette_params
    params.require(:palette).permit(:name, :color_ids)
  end
end
