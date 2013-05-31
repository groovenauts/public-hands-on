Groovenauts Public Hands-on 02
==============================

2013/06/07 @ Groovenauts FUKUOKA office

# 今回の目的

私たちGroovenautsでは提供するサービスを支えるインフラやテストの自動化に力を入れており、
最近ではChefとserverspecに注目しています。

これらの製品を使ってインフラ関連業務を効率的にするための知識、社内外で共有したいと思っております。

また今回は、特別ゲストに 10x Labの春山さんをお呼びして、実際にChefを使用したご経験から
"chef-soloを使ったミニマムなスタートの仕方(仮)"と題して、お話いただきます。



## Chef
Chefは Opscode社が公開しているOSS製品です。
http://www.opscode.com/chef/

https://github.com/opscode/chef のREADME.md によるとこんな説明がされています。

```
Chef is a configuration management tool designed to bring automation to your entire infrastructure.
```

直訳だと「インフラに関わるものをまるごと自動化するように設計された設定管理ツール」ということですね。
実際に使ってみるとかなり簡単に環境構築ができちゃったりして驚きます。

また、Chefで使用する構築のためのレシピ群（== cookbook）も公開されています。
https://github.com/opscode-cookbooks

現時点で138もの製品についてのレシピがあり、よく使われているOSSのミドルウェアのレシピはありそうです。



## serverspec

serverspecは [Gosuke Miyashitaさん](http://mizzy.org/)が公開しているOSS製品です。

http://serverspec.org/ にこんな説明があります。

```
With serverspec, you can write RSpec tests for checking your servers are provisioned correctly.
```

「serverspecを使うとサーバがちゃんと準備できたのかをチェックするテストをRSpecで書けます」

日々RSpecでテストを書いている身からすると非常にありがたい仕組みです。



# 事前準備

当日のハンズオンでは、VagrantからVirtualBox上の仮想サーバを起動してサーバのセットアップと
そのテストを行いますので、参加される皆様はその事前準備をお願いします。

* Vagrant-1.0.7 or 1.1.x
* VirtualBox 最新版推奨


Vagrant の [Getting Started](http://docs.vagrantup.com/v2/getting-started/project_setup.html) を参考に
http://www.vagrantbox.es/ からお手持ちの環境に合う CentOS 6.3 or 6.4 をインストールしてきてください。


またserverspecを動かすためにはRubyが必要ですので、Rubyのインストールもお願いします。

[Rubyのインストール](https://github.com/groovenauts/public-hands-on/blob/master/install/README.md)


# アジェンダ

事前準備に不安のあるかたは17:00から会場を開けますので、早めにお越しいただいて
セットアップをお願いします。

* 17:00 - 18:00 （仮想サーバのセットアップの時間）

* 18:00 - 18:20 Groovenauts渕上 Chefとserverspecの概要
* 18:20 - 19:40 Groovenauts渕上 ハンズオン
* 19:40 - 20:00 10x Lab 春山さん "chef-soloを使ったミニマムなスタートの仕方(仮)"
