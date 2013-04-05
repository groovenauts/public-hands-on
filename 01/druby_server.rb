#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# original
#   http://www2a.biglobe.ne.jp/seki/ruby/d203.html
# Book
#   http://www.amazon.co.jp/dRubyによる分散・Webプログラミング-関-将俊/dp/4274066096

require 'drb/drb'                                        # (1)

class Puts                                               # (2)
  def initialize(stream=$stdout)
    @stream = stream
  end

  def puts(str)
    @stream.puts(str)
  end
end

uri = ARGV.shift
DRb.start_service(uri, Puts.new)                        # (3)
puts DRb.uri
sleep                                                   # (4)
