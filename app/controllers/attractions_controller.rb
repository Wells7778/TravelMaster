class AttractionsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_tags

  def index
    @categories = Category.all.order("attractions_count desc")
    @attractions = Attraction.order("reviews_count desc").includes(:categories_attractions, :categories).limit(6) #attractions以熱門景點為基礎
    @comment = Comment.new

    #進入首頁方式1 分類
    if params[:category_id] && current_user
      @way_check = 1 #用來搭配view 顯示 避免出錯
      @category = Category.find(params[:category_id])
      @attractions = @category.attractions.includes(:reviews)
    elsif params[:list_id] && current_user
      @list = List.find_by(id: params[:list_id])
      @way_check = 3
      @search_tags = @list.travel_tag
      @search_location = @list.origin
      @attractions = @list.attractions.includes(:categories_attractions, :categories, :list_attractions)
                                      .order("list_attractions.id asc")
    end
  end

  def show
    @attraction = Attraction.find(params[:id])
    @comment = Comment.new
    @way_check = 2
    @show_id = params[:id]
    @show = Attraction.find(@show_id)
    render :index
  end

  def search
    # 如果無法取得裝置經緯度且為輸入地址就跳出無法搜尋
    if search_params[:location].blank? && search_params[:geo_location].blank?
      flash[:search] = nil
      redirect_to root_path, alert: "找不到出發地點"
    else
      # 如果沒輸入起始地則使用裝置經緯度當作起始地
      origin = search_params[:location].blank? ? "我的位置" : search_params[:location]
      # 把前端拿回來的tag分類
      # 景點分類屬於Array格式，所以先宣告
      @vibe_tag = []
      search_params[:tags].split(",").each do |tag|
        @travel_tag = Attraction::TRAFFIC[tag] if Attraction::TRAFFIC.has_key?(tag)
        @vibe_tag << tag if Category.order("attractions_count desc").pluck(:tag_name).include?(tag)
        @travel_time = Attraction::TRAVELTIME[tag] if Attraction::TRAVELTIME.has_key?(tag)
      end
      # 預設開車、旅行時間一小時
      @travel_tag ||= "driving"
      @travel_time ||= 3600
      @list = current_user.lists.build(origin: origin, travel_time: @travel_time, travel_mode: @travel_tag, travel_tag: @vibe_tag)
      # 呼叫method geocode把地址轉為經緯度
      if @list.geocode.nil?
        @list.origin_lat = search_params[:geo_location].split(",").first.to_f
        @list.origin_lng = search_params[:geo_location].split(",").last.to_f
      else
        @list.origin_lat = @list.geocode['lat']
        @list.origin_lng = @list.geocode['lng']
      end
      if @list.save
        @list.search_attraction(@vibe_tag).each do |result|
          @list.list_attractions.create(attraction_id: result[:attraction_id], duration: result[:travel_text])
        end
      end
      @way_check = 3
      #以下兩個參數是Search的結果，再看後端要怎摸樣吐景點回來，複寫 @attractions 即可
      @search_tags = @list.travel_tag
      @search_location = @list.origin
      # 搜尋結果直接存在list裏
      @attractions = @list.attractions.includes(:categories_attractions, :categories, :list_attractions)
                                      .order("list_attractions.id asc")
      render :index
    end
  end

  def like
    @attraction = Attraction.find(params[:id])
    @attraction.likes.create!(user: current_user)
    render :json => { :id => @attraction.id }
    #redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unlike
    @attraction = Attraction.find(params[:id])
    likes = Like.where(attraction: @attraction, user: current_user)
    likes.destroy_all
    render :json => { :id => @attraction.id }
    #redirect_back(fallback_location: root_path) # 導回上一頁
  end

  def mytrips
    @favorites = current_user.liked_attractions
    @reviews = current_user.reviews.passed
    @commented = current_user.commented_attractions.distinct
    @lists = current_user.lists.order("created_at desc").limit(5)
  end

  def about
  end

  def browse
    if params[:q]
      @ransack = Attraction.search(params[:q])
      @categories = Category.where(id: params[:q]["categories_id_eq_any"])
    else
      @ransack = Attraction.all.search(params[:q])
    end
    @attractions = @ransack.result(distinct: true)
  end

  private
    def attraction_params
      params.require(:attraction).permit(:name, :image, :description, :address, :lat, :lng, category_ids: [])
    end

    def search_params
      params.require(:search).permit(:location, :tags, :geo_location)
    end

    def set_tags #把我們要的TAG都放在這邊
      @traffic_tags = Attraction::TRAFFIC.keys
      @vibe_tags = Category.order("attractions_count desc").pluck(:tag_name)
      @time_tags = Attraction::TRAVELTIME.keys
    end
end
