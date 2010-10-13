Resizo
=======
A handy little resizer script.

## Required to run
- ruby
- FreeImage

## Required Gems
- trollop
- image_science
- RubyInline

## Installation guide
Run these commands to get the dependencies

        sudo brew install FreeImage
        sudo gem install trollop image_science RubyInline

## Options

        Usage:
            ruby resizo.rb [options]
  
            where [options] are:
              --dest, -d:   Destination image path
              --orig, -o:   Original image path
              --width, -w <i>:   Desired width of image
              --height, -h <i>:   Desired height of image
              --action, -a <s>:   What method to perform
              --version, -v:   Print version and exit
              --help, -e:   Show this message

