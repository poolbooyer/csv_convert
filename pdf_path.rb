# 開発環境 macOS Mojave 言語:ruby  gem:poppler
require 'open-uri'
require 'Poppler'

#file's path
url='T1801.pdf'

#read pdf files
reader= Poppler::Document.new(url)
reader_rm=reader.first.get_text.gsub("
"," ")
data=reader_rm.split(" ")
filename=data[2].delete("(").delete(")")+".csv"

#output read data
File.open(filename,'w') do |csv| # output to csv file
    data.each do |bo|
        csv << bo
    end        
end
