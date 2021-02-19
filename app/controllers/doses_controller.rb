class DosesController < ApplicationController
before_action :set_cocktail, only: [:new, :create]

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail

    if @dose.save
      redirect_to cocktail_path(@cocktail)  # CHECK
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])

    if @dose.destroy
      redirect_to cocktail_path(@dose.cocktail), notice: 'You successfully deleted the ingredient!'
    else
      redirect_to cocktail_path(@dose.cocktail), alert: 'Could not delete the ingredient :('
    end

  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

end
