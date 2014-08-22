require 'nokogiri'
require 'open-uri'
require 'json'

url = "https://zh.wikipedia.org/wiki/%E4%B8%AD%E8%8F%AF%E6%B0%91%E5%9C%8B%E5%8F%B0%E7%81%A3%E5%9C%B0%E5%8D%80%E9%84%89%E9%8E%AE%E5%B8%82%E5%8D%80%E5%88%97%E8%A1%A8"
doc = Nokogiri::HTML(open(url))

puts "Processing html content to hash..."

result = Hash.new
doc.search("//table[@class='wikitable']//tr").each do |tr|
  city_name = tr.search("td[1]").text
  if city_name != ""
    #puts city_name
    dist = tr.search("td[3]").text.split("、")
    result[city_name] = dist
  end
end

puts "Writing to json file..."

File.open("tw_city.json","w") do |f|
  f.write(result.to_json.encode("UTF-8"))
end
