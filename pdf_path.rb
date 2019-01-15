# 開発環境 macOS Mojave 言語:ruby  gem:pdf-reader
require 'pdf-reader'
#読み込み処理
def read
    #元データのパス(コマンドラインで受け取った年、台風の号数を使用)
    url='./basedata/T'+ARGV[0]+'.pdf'
    #読み込み処理の実施
    reader = PDF::Reader.new(url)
    i=0
    $read_data=[]
    #配列に読み込んだ複数ページのデータをまとめる
    reader.pages.each do |page|
        $read_data[i]=page.text
        i=i+1
    end
end

#csvデータの作成処理
def create_data
    #元のデータを一つの文字列に結合
    i=0
    $data=""
    $read_data.each do |page|
        $data=$data+page
        i=i+1
    end
    #pdfの改行コードを"\n"の改行コードに置換
    $data=$data.gsub("
        ","\n")
    #改行コード単位で配列に分割
    $data=$data.split("\n")
    #各行の要素単位での分割処理
    i=0
    $data.each do |line|
        $data[i]=line.split(" ")
        i=i+1
    end
    #出力先ファイル名の定義
    $filename=$data[0][2].delete("(").delete(")")+".csv"
    $path="./outputdata/"+$filename
end
def del_char
    $data.each do |line|
        line.delete("---")
        line.delete("--")
        line.delete("－")
        line.delete("S:")
        line.delete("SE:")
        line.delete("E:")
        line.delete("NE:")
        line.delete("N:")
        line.delete("NW:")
        line.delete("W:")
        line.delete("SW:")
        line.delete("N")
        line.delete("E")
        line.delete("強い")
        line.delete("非常に強い")
        line.delete("大型")
        line.delete("猛烈な")
        line.delete("熱帯低気圧発生")
        line.delete("温帯低気圧に変わる")
        line.delete("消滅")
        line.delete("続く")
        line.delete("中心位置")
        line.delete("中心")
        line.delete("最大")
        line.delete("暴風域半径")
        line.delete("強風域半径")
        line.delete("大きさ・強さ")
        line.delete("等")
        line.delete("月")
        line.delete("日")
        line.delete("時")
        line.delete("緯度")
        line.delete("経度")
        line.delete("hPa")
        line.delete("m/s")
        line.delete("km")
        line.delete("大きさ")
        line.delete("強さ")
        line.delete("気圧")
        line.delete("風速")
    end
end
def del_area
    for num in 0..8 do
        $data.delete_at(0)
    end
    $data.each do |line|
        line.map!{|x| x.to_f}
    end
end
#読み込んだデータの出力処理
def output
    #出力先ファイルを開く
    File.open($path,'w') do |csv|
        #出力データの各行に対しての処理
        $data.each do |line|
            #出力データの各要素に対しての処理
            line.each do|cel|
                if 800.0>cel then
                    csv <<cel.to_s+","
                else
                    csv<<cel.to_s+","
                    break
                end
            end
            csv<<"\n"
        end
    end
end

read
create_data
del_char
del_area
output