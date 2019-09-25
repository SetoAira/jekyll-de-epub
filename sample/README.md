# Jekyll de ePub 使用サンプル
縦書き、横書き、コミックの各サンプルです。  

zipの中身は、  
**.epub：実際に作成したepubファイル。  
_site/：Jekyllが出力したもの。この中身まとめてepubファイルにしています。  
_config.yml：基本設定ファイル  
_data/：目次用のデータなど  
_include/：Jekyllでの処理用  
_layout/：レイアウト  
_plugin/：プラグイン。タグの追加やePub化の仕込みなど  
_sass/：スタイルの元  
_scenario/：文章系はこちらに連番で内容のファイルを  
mimetype：ePubに必要  
META-INF/：ePubに必要  
xhtml/：シナリオ以外のxhtmlにするファイル  
OPS/package.opf：ePubの骨格情報  
OPS/style/：cssの出力先  
OPS/image/：画像ファイル  
OPS/image/comic/：コミックの場合、ここに連番で画像ファイルを  
