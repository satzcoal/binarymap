
require 'net/http'
require 'uri'
require File.expand_path('../download', __FILE__)
require File.expand_path('../id_generator', __FILE__)

gen = IdGenerator.new
#ids = gen.genIDs(2000,10)
ids = gen.getOtherIDs('bitmap/')

puts ids
puts "ids length: #{ids.length}"

down = Download.new

ids.each do |id|

  params = {}
  params["txtarea"] = 'http://www.hm-hx6.com/verify/' + id.to_s
  params["qrtype"] = '0'
  params["error"] = '4'
  params["size"] = '10'
  params["button"] = ''
  uri = URI.parse("http://tool.chinaz.com/qrcode/")

  res = Net::HTTP.post_form(uri, params)

  link = res.body.scan(/(qrcodeimg.*?)\'/).flatten
  down.down("http://tool.chinaz.com/" + link[0], id)
end

#puts res.body
