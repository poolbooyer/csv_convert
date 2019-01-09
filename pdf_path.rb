# 開発環境 macOS Mojave 言語:ruby  gem:poppler
require 'open-uri'
require 'Poppler'

#file's path
url='T1824.pdf'

#read pdf files
reader= Poppler::Document.new(url)
reader_rm=reader.first.get_text.gsub("
"," ")
data=reader_rm.split(" ")

#output read data
File.open('hoge.csv','w') do |csv| # output to csv file
    data.each do |bo|
        csv << bo
    end        
end
