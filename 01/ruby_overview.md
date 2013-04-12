Rubyの概要
===================

# 言語の思想

    「Rubyの言語仕様策定において最も重視しているのはストレスなくプログラミングを楽しむことである」

[設計思想](http://ja.wikipedia.org/wiki/Ruby#.E8.A8.AD.E8.A8.88.E6.80.9D.E6.83.B3)

# 今回のネタ

[githubのリポジトリ](https://github.com/groovenauts/public-hands-on) に公開されています。

    * [ソースコードをダウンロード](https://github.com/groovenauts/public-hands-on/archive/master.zip)
    * 解凍

    $ wget https://github.com/groovenauts/public-hands-on/archive/master.zip
    $ unzip master.zip

カレントディレクトリを01に移動しましょう。

    $ cd public-hands-on-master/01


# 試してみよう

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

gemコマンドでライブラリを簡単にインストールできます。
rackはwebサーバのための共通インタフェースを定義するフレームワークです。
このrackを使ってHTTPサーバを構築してみましょう。

http_server.rb の中身はこれだけです。

    require 'rack'
    Signal.trap(:INT){ exit! }
    my_rack_proc = lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Hello. The time is #{Time.now}"]] }
    Rack::Handler::WEBrick.run my_rack_proc, Port: 9876

このHTTPサーバの起動も簡単です。

    $ ruby http_server.rb

ブラウザで http://localhost:9876 にアクセスしてみると、現在の時刻が表示されます。
リロードすると時刻が更新されるはず。

Ctrl+CでWebサーバを停止できます。


## すごいことでもシンプルに

[標準添付ライブラリ](http://doc.ruby-lang.org/ja/2.0.0/library/index.html) に含まれる
[drb](http://doc.ruby-lang.org/ja/2.0.0/library/drb.html) を例に。

サーバとなるRubyのプロセスのオブジェクトのメソッドを、別のプロセスから呼び出すことができます。

まず２つターミナルを起動します。

### ターミナル1で実行

    $ ruby druby_server.rb
    druby://cloud-dev-6:53845 # ここをコピー


### 最後の引数にターミナル1で出力された結果をコピペして実行

    $ ruby druby_client.rb [ペースト]

こんな感じ

    $ ruby druby_client.rb druby://localhost:53845
    

ターミナル1の方にメッセージが出たら、このソースコードを見てみましょう。


### 他のプロセス間通信の例

* [Java RMIの例](http://e-class.center.yuge.ac.jp/jdk_docs/ja/technotes/guides/rmi/hello/hello-world.html)

