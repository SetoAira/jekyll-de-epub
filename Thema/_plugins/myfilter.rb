module Jekyll
  module MyFilter
    
    def toc(html, fname = "001.xhtml")
      i = 0
      toc_list = +''

      html.scan(/<h[1-6].*?<\/h[1-6]>/) do |header|
        node_name = header.match(/h[1-6]/)[0]
        linkstr = header.sub(/ class=".*?"/,'').sub(/<h[1-6] id="(.*?)<\/h[1-6]>/, '\1</a>')
        toc_list << %(    <li class="toc-#{node_name}"><a href="#{fname}##{linkstr}</li>\n)
        i += 1
      end

      toc_list
      
    end
    
    def nav(html, fname = "xhtml/001.xhtml")
      i = 0
      toc_list = +''

      html.scan(/<h[1-6].*?<\/h[1-6]>/) do |header|
        node_num = header.match(/[1-6]/)[0].to_i
        toc_space = +''
        j = 1
        while j < node_num
          toc_space << ' '
          j += 1
        end
        linkstr = header.sub(/ class=".*?"/,'').sub(/<h[1-6] id="(.*?)>(.*?)<\/h[1-6]>/, '\1>'+toc_space+'\2</a>')
        toc_list << %(      <li><a href="#{fname}##{linkstr}</li>\n)
        i += 1
      end

      toc_list
      
    end
    
    def fix(html)
      emstyle = @context.registers[:site].config['emphasis'] || "sesame"
      html.gsub(/([^\\＿])＿([^<\n]+?)＿/,'\1<span class="tcy">\2</span>').gsub(/([^\\＊])＊([^<\n]+?)＊/,'\1<span class="em-'+emstyle+'">\2</span>').gsub(/([^\\＿])＿《([^<\n]+?)》/,'\1<span class="sub">\2</span>').gsub(/([^\\＾])＾《([^<\n]+?)》/,'\1<span class="super">\2</span>').gsub(/([^\\｜])｜([^<\n]+?)《([^<\n]+?)》/,'\1<ruby>\2<rt>\3</rt></ruby>').gsub(/([一-龠々]+?)《([^<\n]+?)》/,'<ruby>\1<rt>\2</rt></ruby>').gsub(/([^\\＾])＾([^<\n\\]+?)｜([^<\n\\]+?)＾/,'\1<span class="\3">\2</span>').gsub(/\\(＾|＿|｜|《|》|＊)/,'\1')
    end

  end
  
  
end

Liquid::Template.register_filter(Jekyll::MyFilter)