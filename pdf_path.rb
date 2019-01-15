# 開発環境 macOS Mojave 言語:ruby  gem:pdf-reader
#require 'open-uri'
require 'Poppler'
require 'pdf-reader'

def read
    url='./basedata/T'+ARGV[0]+'.pdf'
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
    i=0
    $data=""
    $read_data.each do |page|
        $data=$data+page
        i=i+1
    end
    
    $data=$data.gsub("
        ","\n")
    $data=$data.split("\n")
    i=0
    
    $data.each do |line|
        $data[i]=line.split(" ")
        i=i+1
    end
    puts $data[0][2]
    $filename=$data[0][2].delete("(").delete(")")+".csv"
    $path="./outputdata/"+$filename
end
create_data
#output read data
def output
    File.open($path,'w') do |csv| # output to csv file
        $data.each do |line|
            line.each do|cel|
                csv <<cel+","
            end
            csv<<"\n"
        end
    end
end
output