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
    @traffic_tags = ["T_TAG1","T_TAG2","T_TAG3","T_TAG4"]
    @vibe_tags = ["V_TAG1","V_TAG2","V_TAG3"]
    @time_tags = ["1hours","4hours","6hours"]
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
