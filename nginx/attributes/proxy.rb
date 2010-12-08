nginx Mash.new unless attribute?("nginx")

nginx[:proxy_port] = "80" unless attribute?("nginx_proxy_port")
