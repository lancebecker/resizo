Resizo
=======
Resizo is a simple command line interface for resizing images from the command line using the FreeImage + ImageScience libraries

## Required Libraries/Frameworks
- ruby
- FreeImage

## Required Gems
- image_science
- RubyInline

## Installation guide
Run these commands to get the dependencies needed

        sudo brew install FreeImage
        sudo gem install image_science RubyInline

Or try out the install.sh (still a bit rough)
        
        ./tools/install.sh

## Options

        Usage:
            resizo [options]
  
            where [options] are:
              --dest, -d:   Destination image path
              --orig, -o:   Original image path
              --width, -w <i>:   Desired width of image
              --height, -h <i>:   Desired height of image
              --version, -v:   Print version and exit
              --help, -e:   Show this message
