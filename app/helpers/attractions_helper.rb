module AttractionsHelper
  def show_near_by(id)
    Attraction.find_by(id: id).name
  end

end
