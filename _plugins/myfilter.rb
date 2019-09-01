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

  end
  
  
end

Liquid::Template.register_filter(Jekyll::MyFilter)