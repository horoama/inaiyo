require 'json'
require 'pp'
require 'open-uri'
require 'yo4r'

NHK_TOKEN = 'YOUR NHK TOKEN'
YO_TOKEN = 'YOUR YO TOKEN'

PROGRAM = "いないいない"

def get_nowonair
    begin
	failed ||= 0
	res = open("http://api.nhk.or.jp/v2/pg/now/130/e1.json?key=#{NHK_TOKEN}")
	code, msg = res.status
    rescue
	failed += 1
	sleep 30
	retry if failed < 5
    end

    if code == "200"
	data = JSON.parse res.read
	data
    else
	nil
    end
end


def yoall
    client = Yo::Client.new(api_token: YO_TOKEN)
    client.yoall
end


onair_state = 0 #0 not onair  1 now onair
loop do
    sleep 60
    onair = get_nowonair
    if onair != nil
	next
    end
    present = onair['nowonair_list']['e1']['present']['title']

    if onair_state == 0
	if present.include?(PROGRAM)
	    onair_state = 1
	    puts 'start いないいないばぁ& yoall'
	    yoall
	end
    elsif onair_state == 1
	if !present.include?(PROGRAM)
	    onair_state = 0
	    #puts 'now いないいないばぁ'
	end
    end
end
