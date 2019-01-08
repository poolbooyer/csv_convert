# 開発環境 macOS Mojave 言語:ruby  gem:poppler
require 'open-uri'
require 'Poppler'

#url='https://www.data.jma.go.jp/fcd/yoho/data/typhoon/T1825.pdf'

#files path
url='T1824.pdf'

#read pdf files
reader= Poppler::Document.new(url)

#output read data
puts reader.first.get_text