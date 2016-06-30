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
    present = get_nowonair['nowonair_list']['e1']['present']['title']
    if (present.include?('いないいないばあっ'))
        yoall
    end
    sleep 60
end
