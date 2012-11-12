def sitemaptw
  links = Set[]
  prefix = "http://en.crushermachine.net/"
  Post.all.each do |page|
    links << "#{prefix}crushers/#{page.permalink}"
  end

  builder = Nokogiri::XML::Builder.new do |xml|
    xml.urlset("xmlns"=>"http://www.sitemaps.org/schemas/sitemap/0.9","xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance","xsi:schemaLocation"=>"http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"){
      links.each do |link|
        xml.url{
          xml.loc link
        }
      end
    }
  end

  fi = File.open("public/sitemap.xml","w")
  fi.puts(builder.to_xml)
  fi.close
end
