class BooksController < ApplicationController
  
  before_action :fetch_rakuten_books, only: [:update]

  def index
    @books = Book.all
  end
  
  def update
    @filteredItems.each do |filteredItem|
      filteredItem.fetch_values(:name, :price, :image_url, :image)
      
      #書籍の値段が変更されたとき、データも上書きされるようにしたい
      #Bookテーブルの中から、書名が一致するデータを取り出す。
      existing_book = Book.find_by(name: filteredItem[:name])
      #取り出したデータのpriceが同じなら、何もしない
      #取り出したデータのpriceが異なるなら、そのデータのpriceに値を代入してセーブする。
      if (existing_book == nil) then
        #Bookテーブルの中から書名が一致するデータがなければ、bookインスタンスを生成する
        #bookインスタンスの書名と値段を保存する
        book = Book.new
        book.image_url = filteredItem[:image_url]
        book.price = filteredItem[:price]
        if filteredItem[:name].include?('/')
          filteredItem[:name].gsub('/', '_')
          book.name = filteredItem[:name]
        end
        #画像データをダウンロードする
        save_image(filteredItem)
        book.image = true
        book.save
      elsif (filteredItem[:price] != existing_book.price || filteredItem[:image_url] != existing_book.image_url) then
        existing_book.price = filteredItem[:price]
        existing_book.image_url = filteredItem[:image_url]
        if filteredItem[:name].include?('/')
          filteredItem[:name].gsub('/', '_')
          existing_book.name = filteredItem[:name]
        end
        #画像データをダウンロードする
        save_image(filteredItem)
        existing_book.image = true
        existing_book.save
      elsif filteredItem[:price] == existing_book.price then
        #何もしない
      end
    end
    redirect_to("/books/index")
  end
  
  def save_image(hoge)
    require 'open-uri'
    if hoge[:name].include?('/')
      hoge[:name].gsub('/', '_')
    end
    File.open("/Users/kanazawashin/horse_race_predict/app/assets/images/#{hoge[:id]}.jpg", "wb") do |file|
      begin
        open("#{hoge[:image_url]}") do |img|
          file.puts img.read
        end
      rescue => error
        puts error
      end
    end
  end


  def create
  end

  def fetch_rakuten_books
    require "net/http"
    require 'json'

    uri = URI.parse("https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?format=json&keyword=Ruby%20on%20rails&genreId=101287&sort=-reviewAverage&applicationId=1013313693560279297")
    response = Net::HTTP.get_response(uri)
    @items = JSON.parse(response.body)["Items"]

    @filteredItems = []
    @items.each_with_index do |element, index|
      if (index < 5)
        @filteredItems.push(
          {
            "name": element["Item"]["itemName"],
            "price": element["Item"]["itemPrice"],
            "availability": element["Item"]["availability"],
            "image_url": element["Item"]["mediumImageUrls"][0]["imageUrl"],
            "image": false
          }
        )
      end
    end
  end  

end