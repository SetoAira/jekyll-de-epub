Jekyll::Hooks.register :site, :post_write do |site|
  dir = "_site/OPS/xhtml"
  Dir.chdir(site.source)
  Dir.foreach(dir) do |docfile|
    doc_path = File.join(dir, docfile)
    if File.extname(doc_path) == ".html"
      rm_path = doc_path.sub(/\.html/,'.xhtml')
      File.rename(doc_path, rm_path)
    end
  end
end