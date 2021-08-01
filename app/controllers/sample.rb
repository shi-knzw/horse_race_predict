# require 'open-uri'

# URL = "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/6183/9784774196183.jpg?_ex=128x128"
# require 'open-uri'
# # file = open(URL)
# #puts file.read

# # puts file.base_uri

# file_path = "./test.jpg"
# open(file_path, 'w') do |pass|
#  open(URL) do |file|
#   pass.write(file.read)
#  end
# end

str = "123abc"
puts str.include?("123")
