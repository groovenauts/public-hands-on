require 'drb/drb'
there = DRbObject.new_with_uri(ARGV.first)
there.puts('Hello, World.')
