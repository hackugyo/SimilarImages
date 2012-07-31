# -*- coding: utf-8 -*-
# require 'rubygems' # Ruby 1.8系なら必要

# require 'bundler/setup'
require './opencv'
# include OpenCV

image = OpenCV::IplImage.load '/Users/kwatanabe/projects/ruby/ruby-opencv-sample/test_webcam.jpg'
rgb = OpenCV::RGB2GRAY image
window = OpenCV::GUI::Window.new 'preview'
window.show rgb
OpenCV::GUI::wait_key
OpenCV::GUI::Window.destroy_all
