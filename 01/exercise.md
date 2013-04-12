練習問題
==========

# 問題1

まつもとさんは以前、こんなじゃんけんのプログラムを書きました。

    %w(ぐー ちょき ぱー).shuffule[0]

この場合、"ぐー" "ちょき" "ぱー" のいづれかの文字列が返されます。

以下の関数が定義されていた場合に、からなずpoiの出す手に勝つ手を返すメソッドatodashiを作ってください。

    def poi
      [:goo, :choki, :paa].shuffle[0]
    end

    def atodashi(hand)
      ...
    end

    m1 = poi
    # => :goo # poiがぐーを返したら
    atodashi(m1)
    # => :paa # atodashiはパーを出す

いろいろな書き方ができると思いますが、できるだけシンプルに書いてみましょう。


# 問題2

じゃんけんの判定を行う関数judgeを作りましょう。

    def janken(person1, person2)
      j1 = poi
      j2 = poi

      case judge(j1, j2)
      when -1 then "#{person1} won"
      when  0 then "draw"
      when  1 then "#{person2} won"
      end
    end

実行例

    irb> janken("saishu", "mee")
    mee won


# 問題3

複数人でじゃんけんできるようにjankenメソッドを変えましょう。

実行例

    irb> janken ["saishu", "mee", "nobushino"]
    mee, nobushino won

