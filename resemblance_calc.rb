# -*- encoding: utf-8 -*-

require "RMagick"

include Magick

def get_rgb_arry(file)

  dr = 0
  dg = 0
  db = 0

  # img = ImageList.new(file)
  # 64bitに減色
  img = Image.read(file).at(0).quantize(32) 
  for y in 0...img.rows
    for x in 0...img.columns
      src = img.pixel_color(x, y) # 元画像のピクセルを取得
      
      dr += src.red
      dg += src.green
      db += src.blue
      
    end
  end

  max = (img.rows * img.columns * 255).to_f
  puts "max: #{max}"
  rr = dr.to_f / max
  gg = dg.to_f / max
  bb = db.to_f / max

  puts "Red=%f, Green=%f, Blue=%f" % [rr,gg,bb]
  img.write("sample.jpg")
  return [rr,gg,bb]
end

def comp(arry1,arry2)
  rr_diff = (arry1[0] - arry2[0]) / [arry1[0], arry2[0]].max
  gg_diff = (arry1[1] - arry2[1]) / [arry1[1], arry2[1]].max
  bb_diff = (arry1[2] - arry2[2]) / [arry1[2], arry2[2]].max
  p rr_diff
  p gg_diff
  p bb_diff
  rslt = 1 - (rr_diff ** 2 + gg_diff ** 2 + bb_diff ** 2) / 3
  return rslt
end

pic1, pic2 = ARGV
puts comp(get_rgb_arry(pic1), get_rgb_arry(pic2))
