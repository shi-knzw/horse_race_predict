class BooksController < ApplicationController
  
  before_action :fetch_rakuten_books, only: [:create]

  def index
    @books = Book.all
  end
  
  def create
    @filteredItems.each do |filteredItem|
      filteredItem.fetch_values(:name, :price)
      @book = Book.new()
      @book.name = filteredItem[:name]
      @book.price = filteredItem[:price]
      @book.save
      
      #書籍の値段が変更されたとき、データも上書きされるようにしたい
      #Bookテーブルの中から、書名が一致するデータを取り出す。
      #取り出したデータのpriceが同じなら、何もしない 
      #取り出したデータのpriceが異なるなら、そのデータのpriceに値を代入してセーブする。 i
      #Bookテーブルの中から書名が一致するデータがなければ、bookインスタンスを生成する
      #bookインスタンスの書名と値段を保存する
    end
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
              "availability": element["Item"]["availability"]
            }
          )
      end
    end
  end  

end
