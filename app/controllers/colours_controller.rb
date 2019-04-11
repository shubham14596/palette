class ColoursController < ApplicationController
  before_action :find_colour, only: %i[update destroy edit show]

  def index
    @colours = Colour.order('name').page(params[:page]).per(8)
  end

  def new
    @colour = Colour.new
  end

  def show; end

  def edit; end

  def create
    @colour = Colour.new(colour_params)
    if @colour.save
      flash[:success] = 'Color created successfully'
      redirect_to colours_path
    else
      render 'new'
    end
  end

  def update
    if @colour.update(colour_params)
      flash[:success] = 'Color Updated successfully'
      redirect_to @colour
    else
      render 'edit'
    end
  end

  def destroy
    flash[:danger] = 'colour not deleted' unless @colour.destroy
    redirect_to colours_path
  end

  private

  def find_colour
    @colour = Colour.find_by_id(params[:id])
    return if @colour.present?

    flash[:danger] = 'No colour found'
    redirect_to colours_path
  end

  def colour_params
    params.require(:colour).permit(:name, :hex)
  end
end
