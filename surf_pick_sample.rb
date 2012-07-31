# -*- coding: utf-8 -*-
# require 'rubygems' # Ruby 1.8系なら必要

# require 'bundler/setup'
require './opencv'
include OpenCV

# 画像をロード
filename = ARGV.size > 0 ? ARGV[0] : 'zeus_package.jpg'
mat = CvMat.load(filename, CV_LOAD_IMAGE_ANYCOLOR | CV_LOAD_IMAGE_ANYDEPTH)

# CvMat#extract_surfを使用するためにグレースケール画像に変換
gray = mat.BGR2GRAY

# 画像からSURFのキーポイントとディスクリプタを抽出
keypoints, descriptors = gray.extract_surf(CvSURFParams.new(500, true, 2, 3))

# キーポイントを描画
keypoints.each { |kpt|
  mat.circle!(kpt.pt, (kpt.size * 0.25), :color => CvColor::Blue, :thickness => 1, :line_type => :aa)
}

# 結果を表示
GUI::Window.new('SURF').show mat
GUI::wait_key
