#!/usr/bin/env ruby

require 'rubygems'
require 'fileutils'  
require 'find'
require 'trollop'
require 'image_science'

filepath =  File.dirname(__FILE__)
dirpath = Dir.pwd

opts = Trollop::options do 
  version "Resizo 0.0.1"
  banner <<-EOS
Resizo is a nice and simple CLI to resizing images from the command line using the FreeImage + ImageScience libraries

  Usage:
    resizo [options]
  
  where [options] are:
  EOS
  opt :dest, "Destination image path", :type => :string
  opt :orig, "Original image path", :type => :string
  opt :width, "Desired width of image", :type => :int
  opt :height, "Desired height of image", :type => :int
  opt :action, "What method to perform", :type => :string
end      

class Resizo

  attr_accessor :height, :width, :destination, :originals, :action

  def initialize(opts)
    @height = opts[:height]
    @width = opts[:width]
    @destination = opts[:dest]
    @originals = opts[:orig]
    @action = opts[:action]
  end

  def calculate_ratio
    find_images

    orig_path = @originals + "/" + image   

    image_height = 0
    image_width = 0

    @images.each do |image|
      if @width == nil
        ImageScience.with_image(orig_path) do |img|
          
        end
      end
      if @height == nil

      end
    end
  end

  def find_images
    @images = []
    Find.find(@originals) do |path|
      unless FileTest.directory?(path) || File.basename(path)[0] == ?.
        @images.push(path)
      end
    end
    @images.map! do |image|
      File.basename image
    end
  end

  def folders_exist?
    unless File.directory? destination  
      FileUtils.mkdir(destination)    
    end
  end

  def do_action
    case @action
    when "resize"
      resize
    when "ratio"
      calculate_ratio 
    else
      puts "Incorrect or no argument provided."
      exit
    end
  end

  def resize
    find_images
    folders_exist?
    
    @images.each do |image|
      orig_path = @originals + "/" + image
      dest_path = @destination + "/" + image

      ImageScience.with_image(orig_path) do |img|
        img.resize(@height, @width) do |dest_img|
          dest_img.save "#{dest_path}"
        end
      end
    end

  end
end

resizo = Resizo.new(opts)
resizo.do_action
