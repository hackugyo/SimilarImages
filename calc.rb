# -*- encoding: utf-8 -*-

require 'rubygems'
require 'RMagick'

imgs = Magick::Image.read("./kitten.jpg")
img = imgs.first

# 画像内で使用されている色の一覧を集計
histogram = img.color_histogram.inject({}) {|h,pair|
  color = pair[0].to_color( Magick::AllCompliance, false, 8, true ) 
  h[color] ||= 0
  h[color] += pair[1]
  h
}.sort_by {|pair| pair[1]*-1 } #使用されている順にソート

#割合を算出
pixel_count = img.rows * img.columns
histogram = histogram.map {|i|
  {:color=>i[0], :rate=>(i[1].to_f/pixel_count*10000).to_i/100.0 }
}.reject {|i| i[:rate] <= 0 } # 0.01%未満は除外

#色の一覧を表示
histogram.each {|color|
  puts "#{color[:color]} : #{color[:rate]}%" 
}
