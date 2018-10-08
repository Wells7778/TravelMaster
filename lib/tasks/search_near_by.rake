namespace :update do
  task near_by: :environment do
    def search(origin, id)
      url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
      key = $settings['secret']
      @destinations = Attraction.where.not(id: id)
      dest = @destinations.pluck(:lat, :lng).map { |t| t.join(",")}
      result = []
      @destinations.each do |destination|
        result << { attraction_id: destination.id }
      end
      i = 0
      # 一次送25個景點進去做旅程搜索
      while dest.size > 0
        @params = { origins: origin,
                    destinations: dest.slice!(0,25).join("|"),
                    mode: 'driving',
                    language: 'zh-TW',
                    key: key }
        json_rep = RestClient.get url, { params: @params }
        respond = JSON.parse(json_rep)
        res_array = respond['rows'][0]['elements']
        # 把搜尋出來的旅行時間存進result
        res_array.each_with_index do |res, index|
          if res['status'] == "OK"
            result[index + i * 25 ][:status] = 'OK'
            result[index + i * 25 ][:distance] = res['distance']['value']
          else
            result[index + i * 25 ][:status] = res['status']
            result[index + i * 25 ][:distance] = 9999999
          end
        end
        i += 1
      end
      # 結果把符合旅行時間的元素留下後回傳陣列
      return result.select{ |e| e[:distance] <= 5000 }.sort_by { |element| element[:distance] }
    end
    Attraction.all.each do |attr|
      origin = [attr.lat,attr.lng].join(",")
      result = search(origin, attr.id).map { |e| e[:attraction_id]}
      attr.update(near_by: result)
      puts "#{attr.name} 已更新"
    end
  end
end