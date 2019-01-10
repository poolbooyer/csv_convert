# 開発環境 macOS Mojave 言語:ruby  gem:poppler
#require 'open-uri'
require 'Poppler'

#file's path
url='./basedata/T1813.pdf'

#read pdf files
reader= Poppler::Document.new(url)
reader_rm=reader.first.get_text.gsub("
"," ")
reader_cm=reader_rm.gsub(" ",",")
$data=reader_cm.split(",")
$filename=$data[2].delete("(").delete(")")+".csv"
#puts reader_cm
#output read data
def output
    File.open($filename,'w') do |csv| # output to csv file
        $data.each do |bo|
            csv << bo+","
        end        
    end
end
output