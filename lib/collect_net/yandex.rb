
class SpiderYandex
    def main(page,keyword)
        @keyword = keyword
        url = "http://www.yandex.com/yandsearch?text=#{keyword}&p=#{page}"
        url = URI.escape(url)
        doc = Nokogiri::HTML(open(url))
        vars = Array.new
        i=0
        doc.css('.b-serp2-item').each do |content|
            temp= ""
            content.css('h2 a').each do |a|
                temp << '<li class="byli" ><h5><a href="#" title="' + a.content + '">' + a.content + '</a></h5>'
                temp << "\n"
            end
            content.css('.b-serp2-item__text').each do |p|
                temp << '<p>'+ p.content + '</p>'
                temp << "</li>\n<br />"
            end
            vars[i]=temp
            i=i.succ
        end
        vars.shuffle!
        vars_content =""
        vars.each {|x| vars_content << x unless x.nil? }
        return vars_content
    end

    def html(keyword)
        y = 0.upto(2).collect {|x| x}
        return y.collect {|x| main(x,keyword)}.join(" ")
    end

end

def yandex(keyword_list="keyword",sleep_time=nil)

    position=1
    IO.foreach(keyword_list) do |line|
        line = line.chop
        newspider = SpiderYandex.new
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