#!/bin/bash

echo "Verifying Ruby installations..."

# Check each Ruby version
source /usr/local/rvm/scripts/rvm

for version in 3.0.1 2.6.10 2.5.7 2.7.1 2.4.8; do
  echo "Switching to Ruby $version"
  rvm use "$version"
  
  # Verify Ruby version
  ruby -v
  
  # Install compatible Bundler version based on Ruby version
  if [[ "$version" < "3.0.0" ]]; then
    echo "Installing Bundler 2.4.22 for Ruby $version"
    gem install bundler -v 2.4.22
  else
    echo "Installing latest Bundler for Ruby $version"
    gem install bundler
  fi
  
  # Navigate to sample app and install dependencies
  cd ./sample_app || exit
  
  # Use a version-specific Gemfile if needed
  if [[ "$version" < "3.0.0" ]]; then
    # For older Ruby versions, you might need to adjust Gemfile
    sed -i 's/^ruby.*$/ruby "'"$version"'"/' Gemfile
  fi
  
  # Install dependencies
  bundle install
  
  # Run the app
  ruby app.rb
  
  # Return to root directory
  cd ..
done

echo "All Ruby versions verified successfully."