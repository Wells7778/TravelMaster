# == Schema Information
#
# Table name: lists
#
#  id            :integer          not null, primary key
#  origin        :string           not null
#  origin_lat    :float
#  origin_lng    :float
#  search_params :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#

class List < ApplicationRecord
  has_many :list_attractions, dependent: :destroy
  has_many :attractions, through: :list_attractions

  belongs_to :user

  store :search_params, :accessors => [:travel_time, :travel_mode, :travel_tag]

  after_create :update_lists_attractoins
  # 地址轉換為經緯度
  def geocode
    url = 'https://maps.googleapis.com/maps/api/geocode/json'
    key = $settings['secret']
    params = {address: self.origin, language: 'zh-TW', key: key }
    url = url + "?" + params.to_query
    json_rep = RestClient.get url
    respond = JSON.parse(json_rep)
    if respond['status'] == 'OK'
      return respond['results'][0]['geometry']['location']
    else
      return nil
    end
  end

  # 搜尋景點，傳入景點分類、旅行時間、交通工具、起點資訊
  def search_attraction
    url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
    key = $settings['secret']
    lat = self.origin_lat if self.origin_lat
    lng = self.origin_lng if self.origin_lng
    origin = "#{lat},#{lng}"
    mode = self.travel_mode.nil? ? "driving" : self.travel_mode
    # 依照分類先抓出景點清單
    destinations = Attraction.where(id: CategoriesAttraction.where(category_id: Category.where(tag_name: self.travel_tag).pluck(:id)).pluck(:attraction_id).uniq)
    # 因ＡＰＩ一次只能有25個目的地，故先把景點經緯度取出，先做成Array稍後使用
    dest = destinations.pluck(:lat, :lng).map { |t| t.join(",")}

    # 用來存搜尋結果
    result = []
    # 把景點id先存進result
    destinations.each do |destination|
      result << { attraction_id: destination.id }
    end
    i = 0
    # 一次送25個景點進去做旅程搜索
    while dest.size > 0
      params = { origins: origin,
                  destinations: dest.slice!(0,25).join("|"),
                  mode: mode,
                  language: 'zh-TW',
                  key: key }
      if mode == "bus"
        params[:mode] = "transit"
        params[:transit_mode] = "bus"
      elsif mode == "subway"
        params[:mode] = "transit"
        params[:transit_mode] = "subway"
      end
      json_rep = RestClient.get url, { params: params }
      respond = JSON.parse(json_rep)
      res_array = respond['rows'][0]['elements']
      # 把搜尋出來的旅行時間存進result
      res_array.each_with_index do |res, index|
        if res['status'] == "OK"
          result[index + i * 25 ][:travel_time] = res['duration']['value']
          result[index + i * 25 ][:travel_text] = res['duration']['text']
        else
          result[index + i * 25 ][:travel_time] = self.travel_time + 1
          result[index + i * 25 ][:travel_text] = res['status']
        end
      end
      i += 1
    end
    # 結果把符合旅行時間的元素留下後回傳陣列
    return result.select{ |e| e[:travel_time] <= self.travel_time }.sort_by { |element| element[:travel_time] }
  end

  private
  def update_lists_attractoins
    self.search_attraction.each do |result|
      self.list_attractions.create(attraction_id: result[:attraction_id], duration: result[:travel_text])
    end
  end

end
