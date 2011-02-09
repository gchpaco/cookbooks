nginx Mash.new unless attribute?("nginx")

nginx[:proxy_port] = "8080" unless attribute?("nginx_proxy_port")
