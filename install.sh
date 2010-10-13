echo "----------------------------------------------------"
echo " Installing Resizo dependencies"
echo "----------------------------------------------------"

# Path Variables ------------------------------------------
# ---------------------------------------------------------
HOMEBREW="/usr/local/Cellar"
FREEIMAGE="/usr/local/Cellar/freeimage"


# Homebrew ------------------------------------------------
# ---------------------------------------------------------
echo "--> Checking if Homebrew is available..."
if [ -d "$HOMEBREW" ]; then
  echo "[ok!] Homebrew package manager is already installed" 
else
  echo "Homebrew not found: installing homebrew..."
  ruby -e "$(curl -fsS http://gist.github.com/raw/323731/install_homebrew.rb)"
fi
                          
echo " "

# FreeImage -----------------------------------------------
# ---------------------------------------------------------
echo "--> Checking if FreeImage is installed..."
if [ -L "$FREEIMAGE" ]; then
  echo "FreeImage not found: installing freeimage..."
  sudo brew install freeimage
else
  echo "[ok!] FreeImage is already installed"
fi

echo " "    

# RubyGems ------------------------------------------------
# ---------------------------------------------------------
# brute forcing this atm
echo "--> Installing required gems"
sudo gem install trollop RubyInline image_science 
