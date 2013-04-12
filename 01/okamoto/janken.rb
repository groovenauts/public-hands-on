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

def janken(person1, person2)
  j1 = poi
  j2 = poi

  puts "#{person1} is #{j1}"
  puts "#{person2} is #{j2}"

  case judge(j1, j2)
     when -1 then "#{person1} won"
     when 0 then "draw"
     when 1 then "#{person2} won"
  end
end

def judge(janken1, janken2)
  if janken1 == janken2
    return 0
  elsif janken1 == atodashi(janken2)
    return -1
  else
    return 1
  end
end
