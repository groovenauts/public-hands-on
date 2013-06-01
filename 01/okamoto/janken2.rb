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

def janken(persons)

  jankens = []
  persons.each do |p|
     j = poi
     puts "#{p} is #{j}"
     jankens.push(j)
  end

  uniq_jankens = jankens.uniq
  case uniq_jankens.length
     when 1 then puts "aiko"
     when 3 then puts "aiko"
     else  
       j1 = uniq_jankens[0]
       j2 = uniq_jankens[1]
       won_janken = (judge(j1, j2) == 1) ? j2 : j1
       wons = [] 
       jankens.each_with_index do |j, i|
          wons.push(persons[i]) if j == won_janken
       end
       puts "won #{wons.join(', ')}"
  end

#  case judge(j1, j2)
#     when -1 then "#{person1} won"
#     when 0 then "draw"
#     when 1 then "#{person2} won"
#  end
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
