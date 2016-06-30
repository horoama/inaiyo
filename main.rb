require 'json'
require 'pp'
require 'open-uri'
require 'yo4r'

NHK_TOKEN = 'YOUR NHK TOKEN'
YO_TOKEN = 'YOUR YO TOKEN'

def get_nowonair
    res = open("http://api.nhk.or.jp/v2/pg/now/130/e1.json?key=#{NHK_TOKEN}")
    JSON.parse res.read
end

def yoall
    client = Yo::Client.new(api_token: YO_TOKEN)
    client.yoall
end


loop do
    onair_now = false
    present = get_nowonair['nowonair_list']['e1']['present']['title']

    if onair_now == false
	if (present.include?('いないいないばあっ'))
	    onair_now = true
	    puts 'start いないいないばぁ& yoall'
	    yoall
	end
    elsif !present.include?('いないいないばあっ')
	onair_now = false
	puts 'end いないいないばぁ'
    else
	puts 'not いないいないばぁ'
    end
    sleep 60
end
