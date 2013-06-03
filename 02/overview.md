Overview
===================

# 今回の到達点

* Vagrant をつかって、VirtualBoxの仮想マシンを起動／停止することができる
* Hadoop の擬似分散環境のセットアップを Chef の recipe に記述することができる
* chef-solo & knife-solo をつかって、仮想マシン上にHadoopの擬似分散環境をセットアップすることができる
* serverspecをつかって、Hadoopの擬似分散環境をセットアップが正しく行われたことを確認することができる

## Vagrant

## Chef

```
Infrastructure as Code

Chef はサーバ設定や更新を自行化するツールです。より凝った言い方をすると「サーバの環境のメタデータを管理しノードの役割・状態を収束させるオペレーションフレームワーク」です。
```

[入門Chef Solo - Infrastructure as Code](http://www.amazon.co.jp/%E5%85%A5%E9%96%80Chef-Solo-Infrastructure-Code-ebook/dp/B00BSPH158) より

また、 [中級者以上向けの説明](http://www.slideshare.net/YukihikoSawanobori/what-is-chef201303) がSlideShareにありますので、参考にしてください

### Chef Solo
### knife &  knife solo

### Chefを採用している企業や製品

* Facebook
* AWS OpsWorks

## serverspec

[Resource Types](http://serverspec.org/resource_types.html)