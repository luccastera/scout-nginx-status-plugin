require 'open-uri'

class NginxReport < Scout::Plugin

  def build_report
	url = 'http://127.0.0.1/nginx_status'

	total, requests, reading, writing, waiting = nil

	open(url) {|f|
	  f.each_line do |line|
		total = $1 if line =~ /^Active connections:\s+(\d+)/
		if line =~ /^Reading:\s+(\d+).*Writing:\s+(\d+).*Waiting:\s+(\d+)/
		  reading = $1
		  writing = $2
		  waiting = $3
		end
		requests = $3 if line =~ /^\s+(\d+)\s+(\d+)\s+(\d+)/  
	  end
	}
	
	add_report(:total => total)
	add_report(:reading => reading)
	add_report(:writing => writing)
	add_report(:waiting => waiting)
	add_report(:requests => requests)
  end
end




