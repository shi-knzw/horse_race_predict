class BooksController < ApplicationController
  def index
    require "net/http"
    require 'json'

    uri = URI.parse("https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?format=json&keyword=Ruby%20on%20rails&genreId=101287&sort=-reviewAverage&applicationId=xxx")
    response = Net::HTTP.get_response(uri)

    @response_code = response.code

    @items = JSON.parse(response.body)["Items"]

    @filteredItems = []
    @items.each_with_index do |element, index|
      if (index < 5)
        @filteredItems.push(
            {
              "name": element["Item"]["itemName"],
              "price": element["Item"]["itemPrice"]
            }
          )
      end
    end

    @filteredItems.each do |filteredItem|
      puts filteredItem[:name]
      puts filteredItem[:price]
    end
  end

  # def index
  #   @items = RakutenWebService::Ichiba::Item.search(keyword: 'Ruby')
  #   items.first(5).each do |item|
  #     puts "#{item['itemName']}, #{item.price} yen" # Hashのように値を参照できる
  #   end
  #   puts @items
  # end


end
