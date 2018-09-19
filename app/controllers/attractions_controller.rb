class AttractionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tags

  
  def index   
    @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @attractions = @category.attractions
    else
      @attractions = Attraction.all
    end

    if flash[:value01]
      @test = flash[:value01]
    end

  end

  def show
    @show = Attraction.find(params[:id])
    render "attractions/index"
  end

  def search
    puts search_params
    flash[:value01] = search_params
    redirect_to root_path
  end

  private

    def attraction_params
      params.require(:attraction).permit(:name, :image, :description, :address, :lat, :lng, category_ids: [])
    end

    def search_params
      params.require(:search).permit(:location, :tags)
    end

    def set_tags
      @traffic_tags = ["T_TAG1","T_TAG2","T_TAG3","T_TAG4"]
      @vibe_tags = ["V_TAG1","V_TAG2","V_TAG3"]
      @time_tags = ["1hours","4hours","6hours"]
    end


end
