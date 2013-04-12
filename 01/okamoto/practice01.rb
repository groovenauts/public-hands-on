def poi
   [:goo, :choki, :paa].shuffle[0]
end

def atodashi(hand)
  case hand
     when :goo then :paa
     when :choki then :goo
     when :paa then :choki
  end
end

m1 = poi
puts m1
puts atodashi(m1)
