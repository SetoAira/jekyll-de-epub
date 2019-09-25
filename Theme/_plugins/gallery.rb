module Jekyll
  class GalleryPage < Page
    def initialize(site, base, dir, gal)
      @site, @base, @dir = site, base, dir
      @name = gal['name']

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'gallery.html')
      self.data['link'] = gal['link']
      self.data['file'] = gal['file']
    end
  end

  class GalleryGenerator < Generator
    safe true

    def generate(site)
      if site.config['use-gallery']
        gallery = site.data['gallery']
        i = 0
        while i < gallery.length do
          site.pages << GalleryPage.new(site, site.source, '/OPS/xhtml/', gallery[i])
          i = i + 1
        end
      end
    end
  end
end