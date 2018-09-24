class AttractionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tags

  
  def index
    @categories = Category.all
    @attractions = Attraction.includes(:comments).order("created_at").limit(6) #attractions以熱門景點為基礎
    @attraction = Attraction.find(params[:id])
    @comment = Comment.new
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
        @attractions.merge(Attraction.where(id: flash[:show_id]))
      #進入首頁方式3 Search action
      elsif flash[:search] #從Search action進來
        @way_check = 3
        #以下兩個參數是Search的結果，再看後端要怎摸樣吐景點回來，複寫 @attractions 即可
        @search_tags = flash[:search]["tags"]
        @search_location = flash[:search]["location"]
      end
    end
  end


  def show
    @attraction = Attraction.find(params[:id])
    @comment = Comment.new
    flash[:show_id] = params[:id] #用來傳遞變數
    redirect_to root_path
  end

  def search
    flash[:search] = search_params #用來傳遞變數
    redirect_to root_path
  end

  def like
    @attraction = Attraction.find(params[:id])
    @attraction.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unlike
    @attraction = Attraction.find(params[:id])
    likes = Like.where(attraction: @attraction, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path) # 導回上一頁
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
