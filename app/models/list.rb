class List < ApplicationRecord
  has_many :list_attractions, dependent: :destroy
  has_many :attractions, through: :list_attractions

  belongs_to :user

  store :search_params, :accessors => [:travel_time, :travel_mode]

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
  def search_attraction(tag_name)
    url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
    key = $settings['secret']
    @lat = self.origin_lat if self.origin_lat
    @lng = self.origin_lng if self.origin_lng
    @origin = "#{@lat},#{@lng}"
    @mode = self.travel_mode.nil? ? "driving" : self.travel_mode
    # 依照分類先抓出景點清單
    @destinations = Attraction.where(id: CategoriesAttraction.where(category_id: Category.where(tag_name: tag_name).pluck(:id)).pluck(:attraction_id).uniq)
    # 因ＡＰＩ一次只能有25個目的地，故先把景點經緯度取出，先做成Array稍後使用
    dest = @destinations.pluck(:lat, :lng).map { |t| t.join(",")}

    # 用來存搜尋結果
    result = []
    # 把景點id先存進result
    @destinations.each do |destination|
      result << { attraction_id: destination.id }
    end
    i = 0
    # 一次送25個景點進去做旅程搜索
    while dest.size > 0
      json_rep = RestClient.get url, {params: {origins: @origin,
                                               destinations: dest.slice!(0,25).join("|"),
                                               mode: @mode,
                                               language: 'zh-TW',
                                               key: key }}
      respond = JSON.parse(json_rep)
      res_array = respond['rows'][0]['elements']
      # 把搜尋出來的旅行時間存進result
      res_array.each_with_index do |res, index|
        if res['status'] == "OK"
          result[index + i * 25 ][:travel_time] = res['duration']['value']
        else
          result[index + i * 25 ][:travel_time] = self.travel_time + 1
        end
      end
      i += 1
    end
    # 結果把符合旅行時間的元素留下後回傳陣列
    return result.select{ |e| e[:travel_time] <= self.travel_time }
  end
end
