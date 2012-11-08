require "collect_net/version"
require "mechanize"
require "nokogiri"
require "open-uri"

require "collect_net/yandex"
require "collect_net/google_vn"
require "collect_net/lycos"


module CollectNet

end

class String
	def filter_word
		self.gsub!(/metso|sandvik|terex|shanbao|sbm|shibang|liming|zenith/i,"Zenith")
		self.gsub!(/[\w]+@[\w]+.(com|net|org|cn)/,"")
		self.gsub!(/[\d]{5,12}/,"")
		self.gsub!(/'/,"")
	end
end