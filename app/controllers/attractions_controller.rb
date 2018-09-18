class AttractionsController < ApplicationController
  before_action :authenticate_user!

  
  def index   
    @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @attractions = @category.attractions
    else
      @attractions = Attraction.all
    end
  end

  def show

    @show = Attraction.find(params[:id])
    render "attractions/index"
  end

  private

    def attraction_params
      params.require(:attraction).permit(:name, :image, :description, :address, :lat, :lng, category_ids: [])
    end



end
