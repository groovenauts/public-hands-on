Overview
===================

# 今回の到達点

* Vagrant をつかって、VirtualBoxの仮想マシンを起動／停止することができる
* Hadoop の擬似分散環境のセットアップを Chef の recipe に記述することができる
* chef-solo & knife-solo をつかって、仮想マシン上にHadoopの擬似分散環境をセットアップすることができる
* serverspecをつかって、Hadoopの擬似分散環境をセットアップが正しく行われたことを確認することができる

## やらないこと（≒ そこまで準備が及ばなかったこと）

* ChefのすべてのResourceの解説や、RoleやData Bagを使いこなす
* 自分でResourceを定義する
* BerkshelfでサードパーティのCookbookをBundler風に管理する
* Chef Serverの解説と使用

## Ohai

[ohai!](http://www.urbandictionary.com/define.php?term=ohai!)

[Ohai Trail](http://www.flickr.com/photos/sheilakaymcintyre/8358416747/)

Ohai detects data about your operating system. It can be used standalone, but it’s primary purpose is to provide node data to Chef.
[opscode/ohai](https://github.com/opscode/ohai) より

## Vagrant

Oracle VirtualBoxを利用した仮想マシンをコマンドラインから作成してくれるソフトウェア
設定ファイルをRubyで書くことができ、Chef等とも連携できるので、開発環境をコマンドライン一発で作成することが出来る
[Vagrantで簡単仮想マシン構築](http://www.ryuzee.com/contents/blog/4292) より

VMware Fusion に対応したり、EC2 に対応したりと色々出来るようになっています
[Vagrant コトハジメ](https://gist.github.com/voluntas/5525719) より

## Chef

Infrastructure as Code
Chef はサーバ設定や更新を自動化するツールです。より凝った言い方をすると「サーバの環境のメタデータを管理しノードの役割・状態を収束させるオペレーションフレームワーク」です。
[入門Chef Solo - Infrastructure as Code](http://www.amazon.co.jp/%E5%85%A5%E9%96%80Chef-Solo-Infrastructure-Code-ebook/dp/B00BSPH158) より

また、 [中級者以上向けの説明](http://www.slideshare.net/YukihikoSawanobori/what-is-chef201303) がSlideShareにありますので、参考にしてください

### Chef Solo

Chef のスタンドアロン版

[本家のサイト](http://wiki.opscode.com/display/~tily/Chef+Solo) を参考にしてください

### knife-solo

knife-solo adds a handful of commands that aim to make working with chef-solo as powerful as chef-server.
[knife-solo](http://matschaffer.github.io/knife-solo/) より

### Chefを採用している企業や製品

[Facebook、データセンター自動化ツールにChefの新バージョンを全面採用、Erlangでスケーラビリティ拡大。Opscodeが発表](http://www.publickey1.jp/blog/13/facebookchefcheferlangopscode.html)

[AWS OpsWorks - Chefを使って柔軟にクラウド内のアプリケーション管理ができる新サービスを発表](http://aws.typepad.com/aws_japan/2013/02/aws-opsworks-flexible-application-management-in-the-cloud.html)

## serverspec

[Resource Types](http://serverspec.org/resource_types.html)