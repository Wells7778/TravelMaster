# 專案簡介

## 只是想出門走走

週末有時心血來潮想出遊，因為時間有限，活動的範圍不會很大，搜尋旅遊行程往往都是多點排程的行程或者太多地方無法決定。 抑或是出差在外臨時有的空檔，想要利用有限的時間旅遊，卻往往找到很多資訊。

## Travel Master 來了！

使用者設定出發地點及挑選主題 tag(如心情、群體、目的等)及時程 tag(交通時間範圍)，系統自動推薦景點。 推薦景點會根據使用者的偏好排序，同時點入景點可查看網友的照片及評論(包含針對主題推薦、及交通建議等)。

最後，祝福大家能享受旅行、旅途安全愉快！

---

# User Stories

- 除了註冊和登入頁，使用者一定要登入才能使用網站 (**complete**)
- 使用者能創建帳號、登入、登出 (**complete**)
- 登入的使用者能夠使用以下功能 (**complete**)
  - 首頁查看熱門景點 (**complete**)
  - 可以選擇依主題、交通時間、交通工具、出發地點搜尋適合的景點 (**complete**)
  - 使用者可以允許瀏覽器讀取自身位置作為出發地點 (**complete**)
  - 使用者能夠送出景點遊記，由管理者審核 (**complete**)
  - 使用者能夠對景點留言 (**complete**)
  - 使用者夠收藏景點 (**complete**)
  - 使用者能夠查詢自己最近五筆的搜尋紀錄 (**complete**)
  - 使用者能夠查看所有景點，並按照分類檢索景點 (**complete**)
- 管理者登入網站後，能夠進入後台頁面 (**complete**)
- 管理者 CRUD 主題 (**complete**)
- 管理者可以 CRUD 景點 (**complete**)
- 管理者能夠調整使用者的權限 (**complete**)
- 管理者能夠審核遊記，並確認是否可發布 (**complete**)

---

# API

- Google Distance Matrix API: 同時計算多點路程與時間
- Google Geocoding API: 轉換出發地點與景點的經緯度
- Google Cloud Vision API: 協助確認遊記照片地標
- Python BeautifulSoup: 爬取旅遊網站資訊

