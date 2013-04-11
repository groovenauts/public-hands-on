#!/usr/bin/env ruby

# You have to install rack
# $ gem install rack

# original post
#     http://rubylearning.com/blog/a-quick-introduction-to-rack/

require 'rack'
Signal.trap(:INT){ exit! }
my_rack_proc = lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Hello. The time is #{Time.now}"]] }
Rack::Handler::WEBrick.run my_rack_proc, Port: 9876
