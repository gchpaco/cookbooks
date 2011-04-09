require 'net/https'
require 'uri'

default[:rvm][:releases] = "https://rvm.beginrescueend.com/releases/"
uri = URI.join(node[:rvm][:releases], "latest-version.txt")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true if uri.scheme == "https"
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
http.start {
  http.request_get(uri.path) {|res|
    default[:rvm][:version] = res.body.chomp
  }
}
default[:rvm][:rubies] = ["1.8.7", "1.9.2"]
