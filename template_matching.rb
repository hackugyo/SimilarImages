# -*- coding: utf-8 -*-
# require 'rubygems' # Ruby 1.8系なら必要

# require 'bundler/setup'
require 'pp'
require './opencv'
include OpenCV

# 画像をロード
filename = ARGV.size > 0 ? ARGV[0] : 'zeus_package.jpg'
input    = OpenCV::IplImage.load(filename)
template = OpenCV::IplImage.load('../ruby-opencv-sample/zeus_package.jpg')

# OpenCV::CVMat形式で，全チャンネルでテンプレートマッチした結果が格納されている
# 正規化Correlation Coefficient(:ccoeff)で計算
method = :sqdiff
result = input.match_template(template, method) 
min_score, max_score, min_point, max_point = result.min_max_loc
p "min_score: #{min_score}, max_score: #{max_score}"
p "min_point: #{min_point}"
p "max_point: #{max_point}"

# マッチングしたことを目視確認
from = method == :sqdiff ? min_point : max_point
to = OpenCV::CvPoint.new(from.x + template.width, from.y + template.height)
result_image = input.rectangle(from, to, :color => OpenCV::CvColor::Red, :thickness => 5)

window = OpenCV::GUI::Window.new 'canvas'
window.show result_image
GUI::wait_key
OpenCV::GUI::Window.new('template').show template
GUI::wait_key
OpenCV::GUI::Window.new('original').show input
GUI::wait_key
