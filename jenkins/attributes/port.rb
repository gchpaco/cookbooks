jenkins Mash.new unless attribute?("jenkins")

jenkins[:port] = "8080" unless jenkins.has_key?("port")
