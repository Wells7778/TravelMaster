class AttractionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tags

  
  def index
    @categories = Category.all
    @attractions = Attraction.order("created_at").limit(5) #attractions以熱門景點為基礎

    #進入首頁方式1 分類
    if params[:category_id]
      @way_check = 1 #用來搭配view 顯示 避免出錯
      @category = Category.find(params[:category_id])
      @attractions = @category.attractions
    else
      #進入首頁方式2 Show action
      if flash[:show_id] #從Show action進來
        @way_check = 2
        @show = Attraction.find(flash[:show_id])
        puts("!!!before")
        puts(@attractions)
        @attractions.merge(Attraction.where(id: flash[:show_id]))
        puts("+++++after")
        puts(@attractions)
      #進入首頁方式3 Search action
      elsif flash[:search] #從Search action進來
        @way_check = 3
        @search_tags = flash[:search]["tags"]
        @search_location = flash[:search]["location"]
      end
    end

  end

  def show
    flash[:show_id] = params[:id] #用來傳遞變數
    redirect_to root_path
  end

  def search
    flash[:search] = search_params #用來傳遞變數
    redirect_to root_path
  end

  private

    def attraction_params
      params.require(:attraction).permit(:name, :image, :description, :address, :lat, :lng, category_ids: [])
    end

    def search_params
      params.require(:search).permit(:location, :tags)
    end

    def set_tags #把我們要的TAG都放在這邊
      @traffic_tags = ["BUS","MRT","CAR","SCOOTER"]
      @vibe_tags = ["情侶","家庭","戶外","低消費","刺激","散步","宗教"]
      @time_tags = ["2-3hours","6-8hours","一整天","週末二日"]
    end


end
