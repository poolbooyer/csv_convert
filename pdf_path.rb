# 開発環境 macOS Mojave 言語:ruby  gem:pdf-reader
#require 'open-uri'
require 'Poppler'
require 'pdf-reader'
#file's path

def read
    url='./basedata/T1722.pdf'
    reader = PDF::Reader.new(url)
    i=0
    puts reader.metadata
    $read_data=[]
    reader.pages.each do |page|
        #puts page.text
        $read_data[i]=page.text
        i=i+1
    end
end
read
def create_data
    reader_cm=$read_data[0]
    $data=reader_cm.split(" ")
    $filename=$data[2].delete("(").delete(")")+".csv"
end
create_data
#output read data
def output
    File.open($filename,'w') do |csv| # output to csv file
        $data.each do |bo|
            csv << bo+","
        end        
    end
end
output