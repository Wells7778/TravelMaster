class Admin::AttractionsController < Admin::BaseController
  before_action :set_attraction, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:show, :edit]

  def index
    @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @attractions = @category.attractions
    else
      @attractions = Attraction.all
    end
  end

  def new
    @attraction = Attraction.new
  end


  def create
    @attraction = Attraction.new(attraction_params)
    if @attraction.save
      flash[:notice] = "景點建立完成"
      redirect_to admin_attractions_path
    else
      flash.new[:alert] = @attraction.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @attraction.update(attraction_params)
      flash[:notice] = "景點更新完成"
      redirect_to admin_attractions_path
    else
      flash.new[:alert] = @attraction.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @attraction.destroy
      flash[:notice] = "景點刪除完畢"
      redirect_to admin_attractions_path
    else
      flash[:alert] = @attraction.errors.full_messages.to_sentence
      redirect_to admin_attractions_path
    end
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :image, :description, :address, :lat, :lng, category_ids: [])
  end

  def set_attraction
    @attraction = Attraction.find(params[:id])
  end

  def set_categories
    @categories = @attraction.categories
  end

end