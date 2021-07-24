class BooksController < ApplicationController
  
  before_action :fetch_rakuten_books, only: [:update]

  def index
    @books = Book.all[0..4]
  end
  
  def update
    @filteredItems.each do |filteredItem|
      filteredItem.fetch_values(:name, :price, :image_url)
      
      #書籍の値段が変更されたとき、データも上書きされるようにしたい
      #Bookテーブルの中から、書名が一致するデータを取り出す。
      existing_book = Book.find_by(name: filteredItem[:name])
      puts "--------------------------------------"
      puts existing_book
      puts "--------------------------------------"
      puts filteredItem
      #取り出したデータのpriceが同じなら、何もしない
      #取り出したデータのpriceが異なるなら、そのデータのpriceに値を代入してセーブする。
      if (existing_book == nil) then
        book = Book.new
        book.name = filteredItem[:name]
        book.price = filteredItem[:price]
        book.image_url = filteredItem[:image_url]
        book.save
      elsif (filteredItem[:price] != existing_book.price || filteredItem[:image_url] != existing_book.image_url) then
        existing_book.price = filteredItem[:price]
        existing_book.image_url = filteredItem[:image_url]
        existing_book.save
      elsif filteredItem[:price] == existing_book.price then
        #何もしない
      end
      #Bookテーブルの中から書名が一致するデータがなければ、bookインスタンスを生成する
      #bookインスタンスの書名と値段を保存する
    end

    redirect_to("/books/index")
    
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
            "image_url": element["Item"]["mediumImageUrls"][0]["imageUrl"]
          }
        )
        # puts "-------------------------------------------------"
        # puts element["Item"]["mediumImageUrls"][0]["imageUrl"]
      end
    end
  end  

end
