Rubyとの付き合い方
===================

# 言語の思想

    「Rubyの言語仕様策定において最も重視しているのはストレスなくプログラミングを楽しむことである」

[設計思想](http://ja.wikipedia.org/wiki/Ruby#.E8.A8.AD.E8.A8.88.E6.80.9D.E6.83.B3)


# お手軽さ

インタプリタなので簡単に試せるし、正規表現やちょっと複雑なデータ構造も簡単に書けます。


## 簡単に実行

    $ ruby -e "puts Time.now"

## 簡単に試すのに便利なirb

    $ irb
    
    irb> 1 + 1
    => 2
    
    irb> Time.now
    
    irb> "A" * 100


## 簡単に機能を追加

    $ gem install rack

gemでライブラリを簡単にインストール。

rackはwebサーバのための共通インタフェースを定義するフレームワークです。

    $ irb
    irb> require 'rack'
    irb> Signal.trap(:INT){ exit! }
    irb> my_rack_proc = lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Hello. The time is #{Time.now}"]] }
    irb> Rack::Handler::WEBrick.run my_rack_proc, Port: 9876

お手軽にHTTPを起動できます。

ブラウザで http://localhost:9876 にアクセスしてみると、現在の時刻が表示されます。
リロードすると時刻が更新されるはず。

Ctrl+CでWebサーバを停止できます。


## すごいことでもシンプルに

[標準添付ライブラリ](http://doc.ruby-lang.org/ja/2.0.0/library/index.html) に含まれる
[drb](http://doc.ruby-lang.org/ja/2.0.0/library/drb.html) を例に。

サーバとなるRubyのプロセスのオブジェクトのメソッドを、別のプロセスから呼び出すことができます。




### ターミナル1で実行


### ターミナル2で実行

```
require 'drb/drb'
there = DRbObject.new_with_uri('druby://localhost:12345')
there.puts('Hello, World.')
```


### 他の例

* [Java RMIの例](http://e-class.center.yuge.ac.jp/jdk_docs/ja/technotes/guides/rmi/hello/hello-world.html)

