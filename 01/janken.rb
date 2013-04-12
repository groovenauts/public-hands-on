# Q1

def poi
  [:goo, :choki, :paa].shuffle[0]
end

ATODASHI = {
  :goo => :paa,
  :paa => :choki,
  :choki => :goo
}

def atodashi(hand)
  ATODASHI[hand]
end

# Q2

def judge(a, b)
  return 0 if a == b
  case a
  when :goo   then b == :paa   ? 1 : -1
  when :choki then b == :goo   ? 1 : -1
  when :paa   then b == :choki ? 1 : -1
  end
end


def janken(person1, person2)
  j1 = poi
  j2 = poi

  case judge(j1, j2)
  when -1 then "#{person1} won"
  when  0 then "draw"
  when  1 then "#{person2} won"
  end
end


# Q3

# copied from http://doc.ruby-lang.org/ja/2.0.0/class/Hash.html#I_INVERT
def safe_invert(orig_hash)
  result = Hash.new{|h,key| h[key] = [] }
  orig_hash.each{|key, value|
    result[value] << key
  }
  result
end

def janken(people)
  hands = {}
  people.each do |person|
    hands[person] = poi
  end
  if hands.values.uniq.sort == [:choki, :goo, :paa]
    return "draw"
  end
  if hands.values.uniq.length == 1
    return "draw"
  end
  inversed = safe_invert(hands)
  winners =
    case inversed.keys.sort
    when [:choki, :goo] then inversed[:goo  ]
    when [:choki, :paa] then inversed[:choki]
    when [:goo  , :paa] then inversed[:paa  ]
    else
      puts inversed.keys.inspect
    end
  winners.join(", ") + " won"
end
