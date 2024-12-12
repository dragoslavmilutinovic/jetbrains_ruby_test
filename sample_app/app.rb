require 'bundler/setup'
require 'json'

puts "Ruby Version: #{RUBY_VERSION}"
puts "Running sample application..."

data = {
  ruby_version: RUBY_VERSION,
  platform: RUBY_PLATFORM,
  message: "Ruby multi-version verification successful!"
}

puts JSON.pretty_generate(data)