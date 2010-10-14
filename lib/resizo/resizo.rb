# lib/resizo/resizo.rb

require 'rubygems'
require 'fileutils'  
require 'find'
require 'yaml'
require 'image_science'    

class Resizo

  attr_accessor :height, :width, :destination, :originals, :config

  def initialize(opts)

    if opts[:config] == nil
      @height = opts[:height]
      @width = opts[:width]
      @destination = opts[:dest]
      @originals = opts[:orig]
    else
      @config = opts[:config]
      puts "--> Attempting to load configuration file"
      
      unless configuration = YAML::load(File.open(@config))
        puts "[error!] configuration file did not load correctly."
        exit
      end

      puts "[ok!] loaded configuration file."

      @height = configuration["height"]
      @width = configuration["width"]
      @destination = configuration["destination"].to_s
      @originals = configuration["original"].to_s

    end
  end

  def do_action
    resize
  end   

  def find_images

    @images = []

    # Check to make sure the path to the original images was
    # explicitly set otherwise exit gracefully
    if @originals == nil
      puts "[error!] please provide the path to a directory of images."
      exit
    else
      puts "--> Looking for images at:" + @originals
      puts "[ok!] images found"
    end

    # Based on the path to the original images check to make sure
    # we don't include directories and dotfiles in our image array
    Find.find(@originals) do |path|
      unless FileTest.directory?(path) || File.basename(path)[0] == ?.
        @images.push(path)
      end
    end

    # Getting the proper pathing name for each image and mapping
    # it permanently
    @images.map! do |image|
      File.basename image
    end
  end

  def folders_exist?
    # If the destination or originals directories do not exist exit gracefully
    
    if @destination == nil || @originals == nil
      puts "[error!] please provide a destination directory"
      exit
    end

    unless File.directory? destination  
      FileUtils.mkdir(destination)    
    end
  end

  def calculate_ratio

    # These variables will hold the original images dimensions
    image_height, image_width = 0, 0

    @images.each do |image|
      orig_path = @originals + "/" + image    

      if @width == nil && @height == nil
        puts "[error!] please provide a height or width"
        exit
      end

      # Checking if either height or width was not provided, if
      # either is nil lets gather up the original images dimensions
      # and make sure to keep all the decimal places for now by
      # converting to a float
      if @width == nil || @height == nil
        puts "--> image width or height not provided, attempting autosizing..."
        ImageScience.with_image(orig_path) do |img|
          image_width= img.width.to_f
          image_height = img.height.to_f
        end
      end

      if @width == nil
        puts "[ok!] image width autosized successfully"
        @width = (@height / (image_width / image_height)).to_i
      end

      if @height == nil
        puts "[ok!] image height autosized successfully"
        @height = (@width * (image_width / image_height)).to_i
      end
    end
  end  

  def resize
    find_images # Based on the original path find all the images
    folders_exist? # If destination folder does not exist create it
    calculate_ratio # Calculate a ratio to resize if not explicit
    
    # Lets iterate through each image and then resize and save it
    # to the provided destination
    @images.each do |image|
      orig_path = @originals + "/" + image
      dest_path = @destination + "/" + image

      ImageScience.with_image(orig_path) do |img|
        img.resize(@height, @width) do |dest_img|
          dest_img.save "#{dest_path}"
        end
      end
    end
    puts "[ok!] Resizo converted all images successfully"
  end
end  
