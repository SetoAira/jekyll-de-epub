module Jekyll
  class ComicPage < Page
    def initialize(site, base, dir, file)
      @site, @base, @dir = site, base, dir
      @name = 'c-' + file.sub(/\..+/, '.xhtml')

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'svg.html')
      self.data['comic'] = true
      self.data['layout'] = 'svg'
      self.content = 'comic/' + file
    end
  end

  class ComicGenerator < Generator
    safe true

    def generate(site)
      if site.config['comic']

        dir = "OPS/image/comic"
        Dir.chdir(site.source)
        begin
          Dir.foreach(dir) do |gallery_dir|
            gallery_path = File.join(dir, gallery_dir)
            if gallery_dir.chars.first != "."
              site.pages << ComicPage.new(site, site.source, '/OPS/xhtml/', gallery_dir)
            end
        rescue Exception => e
          puts "Error generating galleries: #{e}"
          puts e.backtrace
        end
      end

      end
    end
  end
end