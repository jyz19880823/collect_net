#es collection with lycos

class SpiderLycos
    def main(page,keyword)
        @keyword = keyword
        a = Mechanize.new do |agent|
            agent.user_agent_alias = 'Mac Safari'
            # agent.set_proxy("172.16.2.139",8087)
        end

        a.get("http://search.lycos.es/web?q=#{keyword}&pn=#{page}") do |doc|

            vars = ""
            doc.search('li.result').each do |content|
                content.css('h4').each do |a|
                    para = rand(100)
                    vars << '<li class="byli"><h5><a href="' + para.to_s + '.php" title="' + a.content + '">' + a.content + '</a></h5>'
                    vars << "\n"
                end
                content.css('p:last-child').each do |p|
                    vars << '<p>'+ p.content + '</p>'
                    vars << "</li>\n<br />"
                end
            end
            return vars
        end

    end

    def html(keyword)
        y = 1.upto(2).collect {|x| x}
        return y.collect {|x| main(x,keyword)}.join(" ")
    end

end


def lycos(keyword_list="keyword",sleep_time=nil)
    position=1
    IO.foreach(keyword_list) do |line|
        line = line.chop
        newspider = SpiderLycos.new
        newhtml = newspider.html(line)
        newhtml.gsub!(/metso|sandvik|terex|shanbao|sbm|shibang|liming|zenith/i,"Zenith")
        newhtml.gsub!(/[\w]+@[\w]+.(com|net|org|cn)/,"")
        newhtml.gsub!(/[\d]{5,12}/,"")
        newhtml.gsub!(/'/,"")
        # newhtml = "<?php $title='" + line + "'; $content='" + "<ul class=\"byul\">" + newhtml + "</ul>" +"'; include('head.php'); include('foot.php'); ?>"
        # line2 = line.split.join("-")

        # fh = File.open("ru/"+p.to_s+".php","w")
        # fh.puts(newhtml)
        # fh.close

        title_output = '$_' + p.to_s + '= "'+ line +'";'
        # fi = File.open("ru/title_russia.php","a")
        # fi.puts(title_output)
        # fi.close### output the titile
        Post.create(:name=>line,:content=>newhtml,:title=>"")


        complete_level = 'name -> ( ' + line + ' ) ; ' + 'row -> ' + position.to_s + ';'
        return complete_level
        position = position.succ

        if sleep_time
            sleep(sleep_time)
        end
    end
end