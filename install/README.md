# もろもろインストール方法

## 前提

ここに記述しているのは、基本的にGroovenautsの社員向けのインストール方法です。

### home brew

Mac OS X でいろんなパッケージをインストールするのに便利なツールです。

    $ ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

http://mxcl.github.io/homebrew/

#### 動作確認

    $ brew -v

### rbenv

rubyのインストールを簡単にやってくれるツールです。いろんなバージョンを入れたい場合にも便利。

    $ brew update
    $ brew install openssl readline libyaml autoconf
    $ brew install rbenv
    $ brew install ruby-build

#### 動作確認

    $ rbenv

http://qiita.com/items/9dd797f42e7bea674705

### rubyのインストール

インストール可能なrubyの一覧

    $ rbenv install -l

2.0.0-devをインストール

    $ rbenv install 2.0.0-dev

2.0.0-devを使うように切り替え

    $ rbenv global 2.0.0-dev


#### 動作確認

使っているrubyのバージョンの確認

    $ rbenv version
    $ ruby -v

その他のコマンドも確認

    $ gem -v
    $ irb -v

#### その他のコマンド

何かgemをインストールしたらインストールしたrubyやgemのパスを通すため実行しなければならない

    $ rbenv rehash

インストール済みのRuby一覧を見る

    $ rbenv versions

rbenv install -l の一覧を更新する

    $ brew upgrade ruby-build


