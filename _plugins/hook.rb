require 'zip'

Jekyll::Hooks.register :site, :post_write do |site|
  Dir.chdir(site.source)
  dir = "_site/OPS/xhtml"
  
  Dir.foreach(dir) do |docfile|
    doc_path = File.join(dir, docfile)
    if File.extname(doc_path) == ".html"
      rm_path = doc_path.sub(/\.html/,'')
      File.rename(doc_path, rm_path)
    end
  end
  
  Dir.chdir("_site/")
  bookname = "../" + site.config['book_name'] + ".epub"
  File.delete(bookname) if File.file?(bookname)
  if site.config['epub_output']

    bookfiles = Dir.glob('OPS/**/*').sort
    Zip::OutputStream.open(bookname) do |out|
      out.put_next_entry("mimetype", '', '', Zip::Entry::STORED)
      out.write( File.read("mimetype") )
      out.put_next_entry("META-INF/container.xml")
      out.write( File.read("META-INF/container.xml") )

      bookfiles.each {
        |bookfile|
        next if bookfile.chars.first == "." or bookfile.include?(".map")
        next unless bookfile.include?(".")
        out.put_next_entry(bookfile)
        out << File.read(bookfile).force_encoding('us-ascii')
      }
    end

  end
  
end

Jekyll::Hooks.register :documents, :pre_render do |document|
  next if document.output_ext == ".xhtml"
  if document.url.include?(".html")
    document.url.sub!(".html", ".xhtml")
  else
    document.url << ".xhtml"
  end
end
