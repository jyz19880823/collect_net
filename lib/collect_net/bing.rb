class SpiderBing
    def main(page,keyword)
        @keyword = keyword
        url = "http://www.bing.com/search?q=#{@keyword}&qs=n&sc=0-0&sp=-1&sk=&first=#{page}&FORM=PERE1"
        url = URI.escape(url)
        doc = Nokogiri::HTML(open(url))
        vars = ""
        doc.css('li.sa_wr').each do |content|
            content.css('h3 a').each do |a|
                para = a.content
                vars << '<h5><a href="/" title="' + a.content + '">' + a.content + '</a></h5>'
                vars << "\n"
            end
            content.css('p').each do |p|
                vars << '<p>'+ p.content + '</p><br />'
                vars << "\n"
            end
        end
        return vars
    end

    def html(keyword)
        y = 1.upto(3).collect {|x| x*10 + 1}
        return y.collect {|x| main(x,keyword)}.join(" ")
    end

end

def bing(keyword_list="keyword",sleep_time=nil)

    position=1
    IO.foreach(keyword_list) do |line|
        line = line.chop
        newspider = SpiderBing.new
        newhtml = newspider.html(line)
        newhtml.filter_word
        # newhtml.gsub!(/metso|sandvik|terex|shanbao|sbm|shibang|liming|zenith/i,"Zenith")
        # newhtml.gsub!(/[\w]+@[\w]+.(com|net|org|cn)/,"")
        # newhtml.gsub!(/[\d]{5,12}/,"")
        # newhtml.gsub!(/'/,"")

        Post.create(:name=>line,:content=>newhtml,:title=>"")


        complete_level = 'name -> ( ' + line + ' ) ; ' + 'row -> ' + position.to_s + ';'
        p complete_level
        position = position.succ

        if sleep_time
            sleep(sleep_time)
        end
    end
end