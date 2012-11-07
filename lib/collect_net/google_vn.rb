
class SpiderVn
    def main(page,keyword)
        @keyword = keyword
        a = Mechanize.new do |agent|
            agent.user_agent_alias = 'Mac Safari'
            # agent.set_proxy("172.16.2.139",8087)
        end

        a.get("http://www.google.com.vn/search?hl=vi&newwindow=1&noj=1&q=#{keyword}&start=#{page}") do |doc|

            vars = ""
            doc.search('li.g').each do |content|
                content.search('h3 a').each do |a|
                    para = rand(800)
                    vars << '<li class="byli"><h5><a href="' + para.to_s + '.php" title="' + a.content + '">' + a.content + '</a></h5>'
                    vars << "\n"
                end
                content.search('.st').each do |p|
                    vars << '<p>'+ p.content + '</p>'
                    vars << "</li>\n<br />"
                end
            end
            return vars
        end

    end

    def html(keyword)
        y = 1.upto(2).collect {|x| x*10}
        return y.collect {|x| main(x,keyword)}.join(" ")
    end

end

def google_vn(keyword_list="keyword",sleep_time=nil)
    position=1
    IO.foreach(keyword_list) do |line|
        line = line.chop
        newspider = SpiderVn.new
        newhtml = newspider.html(line)
        newhtml.gsub!(/metso|sandvik|terex|shanbao|sbm|shibang|liming|zenith/i,"Zenith")
        newhtml.gsub!(/[\w]+@[\w]+.(com|net|org|cn)/,"")
        newhtml.gsub!(/[\d]{5,12}/,"")
        newhtml.gsub!(/'/,"")

        Post.create(:name=>line,:content=>newhtml,:title=>"")

        complete_level = 'name -> ( ' + line + ' ) ; ' + 'row -> ' + position.to_s + ';'
        return complete_level
        position = position.succ

        if sleep_time
            sleep(sleep_time)
        end

    end
end