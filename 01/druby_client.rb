require 'drb/drb'

there = DRbObject.new_with_uri('druby://localhost:12345')

there.puts('Hello, World.')
