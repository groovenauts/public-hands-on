メソッドと制御構造
============================

# メソッド？制御構造？


メソッドは、本来はクラスやなんらかのオブジェクトに所属する関数を指しますが、今日は関数と思ってもらっちゃってOKです。

制御構造は、ifとかforなどのプログラムの動きを制御するための書き方を指します。


## メソッドの書き方

    def foo(bar, baz)
      # 処理の中身
    end

fooがメソッド名で、barとbazが引数です。引数は書かなくても良いし、何個書いてもOKです。

戻り値はreturnで明示的に書くか、最後に評価された式の結果が戻り値となります。

    def foo(bar, baz)
      bar + baz
    end

    foo(1, 2)

もっと詳しい書き方は [こちら](http://doc.ruby-lang.org/ja/1.9.3/doc/spec=2fdef.html#method) を参照してください。


## 変数と定数

Rubyでは名前の1文字目で変数や定数の種類が区別されます。

変数にはローカル変数、インスタンス変数、クラス変数、グローバル変数があります。

インスタンス変数、クラス変数はクラスを使う場合に使いますが、今回は扱いません。

グローバル変数はRubyが定義しているもの以外は使わないほうが良いです。これも今回は扱いません。


今回つかう変数はローカル変数だけです。ローカル変数を使う場合、アルファベット小文字または`_'で始まる名前を使ってください。

定数はアルファベット大文字で始まる名前で定義します。

    foo = 1 # ローカル変数

    FOO = 2 # 定数

もっと詳しい説明は [こちら](http://doc.ruby-lang.org/ja/1.9.3/doc/spec=2fvariables.html) を参照してください。

### クラス名

クラスを定義する方法は今回は紹介しませんが、Rubyが予め定義しているクラスを使うことはあります。
通常のクラスは定数として定義されます。

ただし、定数名は全て大文字にするのに対して、クラス名はキャメルケースで書くことが一般的です。

    Time          # 定義済みクラス名
    RUBY_PLATFORM # 定義済み定数名



## 制御構造

### 条件分岐

#### if

if と endで基本的な条件分岐ができます。elsifとelseも使えます。

    a = 1
    b = nil

    if a == 0
      b = 1
    elsif a == 1
      b = 2
    else
      b = 3
    end

rubyのif文は式なので結果を返すことができるので、こんな書き方もできます。

    b =
      if a == 0
        1
      elsif a == 1
        2
      else
        3
      end

thenを使うとこんな風に。

    b =
      if a == 0 then 1
      elsif a == 1 then 2
      else 3
      end

#### case

上記の分岐をcaseを使って書き換えるとこんな感じ。

    b =
      case a
      when 0 then 1
      when 1 then 2
      else 3
      end

#### 3項演算子

他の言語にもよくある3項演算子も使えます。

    c = (a == 1) ? 2 : 3


#### 倒置if

    b = 1
    b = 2 if a == 1

#### unless

ifの逆です

    b = 0
    unless a == 0
      b = 1
    end

これは以下と同じ意味。

    if a != 0
      b = 1
    end


倒置unlessもあります。



### 繰り返し

#### while

    a = 0
    while a < 10
      puts a
      a += 1
    end


#### until

    a = 0
    until a >= 10
      puts a
      a += 1
    end

#### 倒置できるよ

    def inc_and_puts(n)
      puts n
      n + 1
    end

    a = 0
    a = inc_and_puts(a) while a < 10

#### for

ほとんど使われないfor文。

    for i in [1,2,3]
      puts i
    end

普通はこう書きます。

    [1,2,3].each do |i|
      puts i
    end
