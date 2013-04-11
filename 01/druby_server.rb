#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# original
#   http://www2a.biglobe.ne.jp/seki/ruby/d203.html
# Book
#   http://www.amazon.co.jp/dRubyによる分散・Webプログラミング-関-将俊/dp/4274066096

require 'drb/drb'
DRb.start_service(ARGV.first, $stdout)
puts DRb.uri
sleep
