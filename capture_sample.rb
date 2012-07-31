# -*- coding: utf-8 -*-
# require 'rubygems' # Ruby 1.8系なら必要

# http://www.mk-mode.com/wordpress/2011/12/12002047/
require './opencv'
include OpenCV
 
# カメラでのキャプチャ開始
capture = CvCapture.open(0)
 
# キャプチャ画像の取得
img = capture.query.to_CvMat
 
# 画面の縮小
size = CvSize.new(320, 240)
 
# 画像のリサイズ
img = img.resize(size)
 
# 画像の保存
img.save_image( "test_webcam.jpg" )
