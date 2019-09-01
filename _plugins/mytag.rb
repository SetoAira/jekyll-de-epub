module Jekyll
  class LinkGalleryTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      super
      
      param = markup.split
      @link = param[0]
      @id = param[1]
    end

    def render(context)
      gmark = context.registers[:site].config['gallery-mark'] || "&gt;★"
      %(<span class="ref" id="#{@id}"><a href="#{@link}">#{gmark}</a></span>)
    end
  end

  class LinkRefTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      super
      
      param = markup.split
      @link = param[0]
      @id = param[1]
    end

    def render(context)
      rmark = context.registers[:site].config['ref-mark'] || "※"
      %(<span class="ref" id="#{@id}"><a epub:type="noteref" href="note.xhtml##{@link}">#{rmark}</a></span>)
    end
  end
  
  class SpanTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      super
        
      param = markup.split
      @text = param[0]
      @class = +''
      i = 1
      while i < param.length
        if i > 1
          @class << ' '
        end
        @class << param[i]
        i += 1
      end
    end

    def render(context)
      %(<span class="#{@class}">#{@text}</span>)
    end
  end

  class GaijiTag < Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      @image = markup
    end
    
    def render(context)
      %(<img src="../image/#{@image}" class="gaiji"/>)
    end
  end

  class WrefTag < Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      @text = markup.sub(/\s/,'')
    end
    
    def render(context)
      len = (@text.length.to_f / 2).ceil
      dire = context.registers[:page]['direction'] ||  context.registers[:site].config['direction']
      if dire == "rtl"
        len2 = "height:"
      else
        len2 = "width:"
      end
      len2 << len.ceil.to_s
      len2 << "em;"
      %(<span class="wref" style="#{len2}">#{@text}</span>)
    end
  end

end

Liquid::Template.register_tag('gal', Jekyll::LinkGalleryTag)
Liquid::Template.register_tag('ref', Jekyll::LinkRefTag)
Liquid::Template.register_tag('span', Jekyll::SpanTag)
Liquid::Template.register_tag('gaiji', Jekyll::GaijiTag)
Liquid::Template.register_tag('wref', Jekyll::WrefTag)